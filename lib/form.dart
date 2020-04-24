import './bloc/worker_bloc.dart';
import './db/database_provider.dart';
import './events/add_worker.dart';
import './events/update_worker.dart';
import './model/names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerForm extends StatefulWidget {
  final Worker worker;
  final int workerIndex;

  WorkerForm({this.worker, this.workerIndex});

  @override
  State<StatefulWidget> createState() {
    return WorkerFormState();
  }
}

class WorkerFormState extends State<WorkerForm> {
  String _name;
  String _surname;
  String _middleName;
  String _dateOfBirth;
  String _post;
  bool isChildren = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(labelText: 'Name'),
    
     
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildSurname() {
    return TextFormField(
      initialValue: _surname,
      decoration: InputDecoration(labelText: 'Surname'),
   
   
      validator: (String value) {
        if (value.isEmpty) {
          return 'Surname is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _surname = value;
      },
    );
  }

  Widget _buildmMiddleName() {
    return TextFormField(
      initialValue: _middleName,
      decoration: InputDecoration(labelText: 'Middle Name'),
  
     
      validator: (String value) {
        if (value.isEmpty) {
          return 'Middle Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _middleName = value;
      },
    );
  }

  Widget _buildDateOfBirth() {
    return TextFormField(
        keyboardType: TextInputType.number,
      initialValue: _dateOfBirth,
      decoration: InputDecoration(labelText: 'Date Of Birth'),
       
    
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date Of Birth is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _dateOfBirth = value;
      },
    );
  }

  Widget _buildPost() {
    return TextFormField(
      initialValue: _post,
      decoration: InputDecoration(labelText: 'Post'),

      validator: (String value) {
        if (value.isEmpty) {
          return 'Post Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _post = value;
      },
    );
  }

  Widget _buildIsChildren() {
    return SwitchListTile(
      title: Text("Children?", style: TextStyle(fontSize: 20)),
      value: isChildren,
      onChanged: (bool newValue) => setState(() {
        isChildren = newValue;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.worker != null) {
      _name = widget.worker.name;
      _surname = widget.worker.surname;
      _middleName = widget.worker.middleName;
      _dateOfBirth = widget.worker.dateOfBirth;
      _post = widget.worker.post;
      isChildren = widget.worker.isChildren;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Worker Form")),
      body: Container(
      
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildSurname(),
              _buildmMiddleName(),
              _buildDateOfBirth(),
              _buildPost(),
              SizedBox(height: 16),
              _buildIsChildren(),
              SizedBox(height: 20),
              widget.worker == null
                  ? RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        Worker worker = Worker(
                          name: _name,
                          surname: _surname,
                          middleName: _middleName,
                          dateOfBirth: _dateOfBirth,
                          post: _post,
                          isChildren: isChildren,
                        );

                        DatabaseProvider.db.insert(worker).then(
                              (storedWorker) =>
                                  BlocProvider.of<WorkerBloc>(context).add(
                                AddWorker(storedWorker),
                              ),
                            );

                        Navigator.pop(context);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              print("form");
                              return;
                            }

                            _formKey.currentState.save();

                            Worker worker = Worker(
                              name: _name,
                              surname: _surname,
                              middleName: _middleName,
                              dateOfBirth: _dateOfBirth,
                              post: _post,
                              isChildren: isChildren,
                            );

                            DatabaseProvider.db.update(widget.worker).then(
                                  (storedWorker) =>
                                      BlocProvider.of<WorkerBloc>(context).add(
                                    UpdateWorker(widget.workerIndex, worker),
                                  ),
                                );

                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
