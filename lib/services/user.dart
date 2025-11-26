import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hammad_wasay_firebase/models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .set(model.toJson());
  }

  ///Get User by ID
  Future<UserModel> getUserByID(String userID) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(userID)
        .get()
        .then((val) => UserModel.fromJson(val.data()!));
  }
}
