import 'package:batsystem/controll/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      // ignore: deprecated_member_use
      Firestore.instance.collection("users");

  FirestoreService(createUser);

  Future createUser(UserS user) async {
    try {
      // ignore: deprecated_member_use
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }
}
