import './db/database_provider.dart';
import './events/delete_worker.dart';
import './events/set_worker.dart';
import './form.dart';
import './model/names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/worker_bloc.dart';

class WorkerList extends StatefulWidget {
  const WorkerList({Key key}) : super(key: key);

  @override
  _WorkerListState createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getWorkers().then(
      (workerList) {
        BlocProvider.of<WorkerBloc>(context).add(SetWorkers(workerList));
      },
    );
  }

  showWorkerDialog(BuildContext context, Worker worker, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${worker.name} ${worker.middleName} ${worker.surname}'),
        content: Text("ID ${worker.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerForm(worker: worker, workerIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(worker.id).then((_) {
              BlocProvider.of<WorkerBloc>(context).add(
                DeleteWorker(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire worker list scaffold");
    return Scaffold(
      appBar: AppBar(title: Text("Workers EKF")),
      body: Container(
        child: BlocConsumer<WorkerBloc, List<Worker>>(
          builder: (context, workerList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                print("workerList: $workerList");
                      
                Worker worker = workerList[index];
                return ListTile(
                    title: Text('${worker.name} ${worker.middleName} ${worker.surname}'),
                    trailing: Text('${worker.dateOfBirth}'),
                       
                    subtitle: Text(
                      "Post: ${worker.post}\nChildren: ${worker.isChildren}", 
                    ),
                  

                    onTap: () => showWorkerDialog(context, worker, index));
              },
              itemCount: workerList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, workerList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => WorkerForm()),
        ),
      ),
    );
  }
}
