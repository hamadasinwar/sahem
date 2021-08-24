import 'package:firedart/firedart.dart';
import '../models/user.dart';

class FirestoreServices{

  static CollectionReference usersRef = Firestore.instance.collection("users");

  Future<Document> signUp(MyUser user)async{
     return await usersRef.add(user.toMap());
  }

  static Future updateUser(MyUser user)async{
    return await usersRef.document(user.id!).set(user.toMap());
  }

  Future<List<MyUser>> get users async{
    var u = await usersRef.get();

    return u.map((doc) => MyUser(document: doc).fromFirebase()).toList();
  }

}