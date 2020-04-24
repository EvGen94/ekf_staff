import '../events/add_worker.dart';
import '../events/delete_worker.dart';
import '../events/worker_event.dart';
import '../events/set_worker.dart';
import '../events/update_worker.dart';
import '../model/names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerBloc extends Bloc<WorkerEvent, List<Worker>> {
  @override
  List<Worker> get initialState => List<Worker>();

  @override
  Stream<List<Worker>> mapEventToState(WorkerEvent event) async* {
    if (event is SetWorkers) {
      yield event.workerList;
    } else if (event is AddWorker) {
      List<Worker> newState = List.from(state);
      if (event.newWorker != null) {
        newState.add(event.newWorker);
      }
      yield newState;
    } else if (event is DeleteWorker) {
      List<Worker> newState = List.from(state);
      newState.removeAt(event.workerIndex);
      yield newState;
    } else if (event is UpdateWorker) {
      List<Worker> newState = List.from(state);
      newState[event.workerIndex] = event.newWorker;
      yield newState;
    }
  }
}
