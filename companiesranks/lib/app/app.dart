import 'package:companiesranks/app/theme.dart';
import 'package:companiesranks/common/constants/env.dart';
import 'package:companiesranks/common/http/api_provider.dart';
import 'package:companiesranks/common/utils/internet_check.dart';
import 'package:companiesranks/feature/import_data/bloc/company_name_bloc.dart';
import 'package:companiesranks/feature/import_data/resource/company_name_repository.dart';
import 'package:companiesranks/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class App extends StatelessWidget {
  final Env env;
  App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(env),
          lazy: true,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CompanyNameBloc>(
            create: (context) => CompanyNameBloc(
              companyNameRepository: CompanyNameRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                internetCheck: RepositoryProvider.of<InternetCheck>(context),
              )
            ),
          ),
        ],
        child: MaterialApp(
          title: "Company Ranks",
          theme: appTheme(),
          home: HomeNavigation(),
        ),
      ),
    );
  }
}
