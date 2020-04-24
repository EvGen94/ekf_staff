import '../model/names.dart';
import 'worker_event.dart';

class SetWorkers extends WorkerEvent {
  List<Worker> workerList;

  SetWorkers(List<Worker> workers) {
    workerList = workers;
  }
}
