import 'package:flutter/material.dart';
import 'package:infinite_lists/app.dart';
import 'package:infinite_lists/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}
