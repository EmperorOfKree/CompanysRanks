
import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/company_rank/bloc/company_rank_bloc.dart';
import 'package:companiesranks/feature/company_rank/resource/company_rank_repository.dart';
import 'package:companiesranks/feature/company_rank/ui/company_rank_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyRankPage extends StatefulWidget {
  static const String routeName = 'company_rank_page';
  @override
  _CompanyRankPageState createState() => _CompanyRankPageState();
}

class _CompanyRankPageState extends State<CompanyRankPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _reload = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRankBloc(
        companyRankRepository: CompanyRankRepository(
          apiProvider: RepositoryProvider.of<ApiProvider>(context),
          internetCheck: RepositoryProvider.of<InternetCheck>(context),
        ),
      )..add(Fetch()),
      child: BlocBuilder<CompanyRankBloc, CompanyRankState>(
        builder: (context, state) {
          if (state is CompanyRankEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CompanyRankError) {
            return const Center(
              child: Text('ERROR'),
            );
          }

          if (state is CompanyRankLoaded) {
            if (state.companiesRanks.isEmpty) {
              return const Center(
                child: Text("Sem empresas cadastradas",
                      style: TextStyle(color: Colors.white, fontSize: 20)
                    ),
              );
            }
            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              body: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.companiesRanks.length,
                        itemBuilder: (context, index) {
                          return CompanyRankItem(
                            companyRank: state.companiesRanks[index],
                          );
                        }
                      )
                    )
                  ]
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
