import 'worker_event.dart';

class DeleteWorker extends WorkerEvent {
  int workerIndex;

  DeleteWorker(int index) {
    workerIndex = index;
  }
}
