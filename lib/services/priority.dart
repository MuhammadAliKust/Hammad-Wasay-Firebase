import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hammad_wasay_firebase/models/priority.dart';

class PriorityServices {
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Get Priority
  Future<List<PriorityModel>> getPriority() async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .get()
        .then(
          (priorityList) => priorityList.docs
              .map(
                (priorityJson) => PriorityModel.fromJson(priorityJson.data()),
              )
              .toList(),
        );
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete Priority
  Future deletePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .delete();
  }
}
