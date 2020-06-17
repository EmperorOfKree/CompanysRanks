import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/company/bloc/company_bloc.dart';
import 'package:companiesranks/feature/company/model/company.dart';
import 'package:companiesranks/feature/company/resource/company_repository.dart';
import 'package:companiesranks/feature/company_rank/model/company_rank.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyPage extends StatefulWidget {
  static const String routeName = 'sub_company_page';
  CompanyRank _model;

  CompanyPage(CompanyRank model) {
    this._model = model;
  }

  @override
  _CompanyPageState createState() => _CompanyPageState(this._model);
}

class _CompanyPageState extends State<CompanyPage> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CompanyRank _model;

  _CompanyPageState(CompanyRank model) {
    this._model = model;
  }

  /// Create one series with hard coded data.
  static List<charts.Series<Company, int>> _createSampleData(List<Company> scores) {
    return [
      new charts.Series<Company, int>(
          id: 'HistoricoEmpresa',
          domainFn: (Company score, _) => scores.indexOf(score),
          measureFn: (Company score, _) => score.score,
          data: scores,
          
          labelAccessorFn: (Company row, _) => 'Teste Louco')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyBloc(
        companyRepository: CompanyRepository(
          apiProvider: RepositoryProvider.of<ApiProvider>(context),
          internetCheck: RepositoryProvider.of<InternetCheck>(context),
        ),
      )..add(Fetch(_model.companyId.toString())),
      child: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CompanyError) {
            return const Center(
              child: Text('ERROR'),
            );
          }

          if (state is CompanyLoaded) {
            if (state.companyReports.isEmpty) {
              return const Center(
                child: Text("Sem notas e/ou débitos emitidos",
                      style: TextStyle(color: Colors.white, fontSize: 20)
                    ),
              );
            }
            
            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  "${_model.companyName}",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.purple,
                brightness: Brightness.dark,
                actions: <Widget>[],
              ),
              body: WillPopScope(
                onWillPop: () {
                  Navigator.pop(context, false);
                  return new Future(() => false);
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                        child: new Text(
                          "Evolução da pontuação:",
                          style: TextStyle(color: Colors.black, fontSize: 24)
                        )
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: new SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: new charts.LineChart(_createSampleData(state.companyReports),
                            animate: true,
                            defaultRenderer: new charts.LineRendererConfig(includePoints: true)
                          )
                        )
                      )
                    ]
                  )
                )
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
}
