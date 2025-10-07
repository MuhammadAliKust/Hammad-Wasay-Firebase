import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hammad_wasay_firebase/models/task.dart';

class TaskServices {
  //create Task
  Future createTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
  }

  //update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({
          'title': model.title,
          'image': model.image,
          'description': model.description,
        });
  }

  //delete Task
  Future deleteTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .delete();
  }

  //markTaskCompleted
  Future markTaskAsComplete(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'isCompleted': true});
  }

  ///Get All Task
  Stream<List<TaskModel>> getAllTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get In Completed Task
  Stream<List<TaskModel>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
