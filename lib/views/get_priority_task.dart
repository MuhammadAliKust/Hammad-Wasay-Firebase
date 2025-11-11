import 'package:flutter/material.dart';
import 'package:hammad_wasay_firebase/models/priority.dart';
import 'package:hammad_wasay_firebase/models/task.dart';
import 'package:hammad_wasay_firebase/services/task.dart';
import 'package:provider/provider.dart';

class GetPriorityTaskView extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTaskView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      body: StreamProvider.value(
        value: TaskServices().getPriorityTask(model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
