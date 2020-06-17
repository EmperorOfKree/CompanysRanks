import 'package:bloc/bloc.dart';
import 'package:companiesranks/app/app.dart';
import 'package:companiesranks/common/blocs/simple_bloc_delegation.dart';
import 'package:companiesranks/common/constants/env.dart';
import 'package:flutter/material.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(env: EnvValue.development));
}
