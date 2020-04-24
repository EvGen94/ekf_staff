import './workers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/worker_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkerBloc>(
      create: (context) => WorkerBloc(),
      child: MaterialApp(
        title: 'For EKF',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: WorkerList(),
      ),
    );
  }
}

