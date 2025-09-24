import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hammad_wasay_firebase/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
  }

  ///Delete Task
  Future deleteTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .delete();
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///Get All Task
  ///Get Completed Tasks
  ///Get InCompleted Tasks
  ///Mark Task as Complete
  Future markTaskAsComplete(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'isCompleted': true});
  }
}
