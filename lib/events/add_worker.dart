import '../model/names.dart';
import 'worker_event.dart';

class AddWorker extends WorkerEvent {
  Worker newWorker;

  AddWorker(Worker worker) {
    newWorker = worker;
  }
}
