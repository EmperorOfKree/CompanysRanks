import 'dart:convert';
import 'dart:io';

import 'package:companiesranks/common/constants/env.dart';
import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/import_data/bloc/company_name_bloc.dart';
import 'package:companiesranks/feature/import_data/model/company_name.dart';
import 'package:companiesranks/feature/import_data/resource/company_name_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:async/async.dart';

class ImportDataPage extends StatefulWidget {
  static const String routeName = 'import_data_page';
  @override
  _ImportDataPageState createState() => _ImportDataPageState();
}

class _ImportDataPageState extends State<ImportDataPage> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<CompanyName>> _dropDownMenuItems;
  CompanyName _currentCompany;
  String _fileName = '...';
  String _path = '...';
  bool _firstLoad = true;
  List<String> extensions = new List<String>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    extensions.add("csv");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<CompanyName>> getDropDownMenuItems(List<CompanyName> companyNames) {
    List<DropdownMenuItem<CompanyName>> items = new List();

    for (CompanyName companyName in companyNames) {
      items.add(new DropdownMenuItem(
          value: companyName,
          child: new Text(companyName.companyName)
      ));
    }

    return items;
  }

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: extensions);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

    if (!mounted) return;

    setState(() {
      _fileName = _path != null ? _path.split('/').last : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyNameBloc(
        companyNameRepository: CompanyNameRepository(
          apiProvider: RepositoryProvider.of<ApiProvider>(context),
          internetCheck: RepositoryProvider.of<InternetCheck>(context),
        ),
      )..add(Fetch()),
      child: BlocBuilder<CompanyNameBloc, CompanyNameState>(
        builder: (context, state) {
          if (state is CompanyNameEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CompanyNameError) {
            return const Center(
              child: Text('ERROR'),
            );
          }

          if (state is CompanyNameLoaded) {
            if (state.companyNames.isEmpty) {
              return const Center(
                child: Text("Sem empresas cadastradas"),
              );
            }

            if (_firstLoad) {
              _dropDownMenuItems = getDropDownMenuItems(state.companyNames);
              _currentCompany = _dropDownMenuItems[0].value;
              _firstLoad = false;
            }
            

            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  "Importar Arquivo",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                brightness: Brightness.dark,
              ),
              body: Container(
                color: Colors.white,
                child: new Center(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                            "Selecione uma empresa:",
                            style: TextStyle(color: Colors.black, fontSize: 16)
                          ),
                        new DropdownButton(
                          value: _currentCompany,
                          items: _dropDownMenuItems,
                          onChanged: (value) => changedDropDownItem(value),
                          
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: new RaisedButton(
                            onPressed: () => _openFileExplorer(),
                            child: new Text("Selecionar arquivo"),
                          ),
                        ),
                        new Text(
                          'URI PATH',
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          _path ?? '...',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          textScaleFactor: 0.85,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new Text(
                            'FILE NAME',
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Text(
                          _fileName,
                          textAlign: TextAlign.center,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                          child: new RaisedButton(
                            onPressed: () {
                              if (_fileName == '...' || _path == '...') {
                                return null;
                              }
                              
                              return this.sendData(_path, _fileName);
                            },
                            child: new Text("Importar"),
                          ),
                        ),
                      ],
                    )
                ),
              )
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void changedDropDownItem(CompanyName selectedCompany) {
    setState(() {
      _currentCompany = selectedCompany;
    });
  }

  void sendData(String path, String fileName) async {
    File imageFile = File(path);

    var stream = new ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(EnvValue.development.baseUrl + "/importData");

    var request = new MultipartRequest("POST", uri);
    var multipartFile = new MultipartFile('file', stream, length, filename: fileName);

    request.fields['company_id'] = _currentCompany.companyId.toString();
    request.files.add(multipartFile);
    var response = await request.send();

    _showDialog(response.statusCode);
  }

  _showDialog(int statusCode) {
    String mensagem = statusCode == 200 ? "Arquivo importado com sucesso" : "Erro ao importar arquivo";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Resultado importação"),
          content: new Text(mensagem),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
