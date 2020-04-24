import '../model/names.dart';
import 'worker_event.dart';

class UpdateWorker extends WorkerEvent {
  Worker newWorker;
  int workerIndex;

  UpdateWorker(int index, Worker worker) {
    newWorker = worker;
    workerIndex = index;
  }
}
