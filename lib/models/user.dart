import 'package:firedart/firedart.dart';

class MyUser{

  static const userID = 'userID';
  static const userName = 'username';
  static const userPhone = 'userPhone';
  static const userPassword = 'userPassword';
  static const userState = 'userState';
  static const userAddress = 'userAddress';

  String? id;
  String? name;
  String? phone;
  String? state;
  String? address;
  String? password;
  Document? document;

  MyUser({this.id, this.name, this.phone, this.state, this.document, this.address, this.password});

  factory MyUser.fromMap(Map<String, dynamic> json) =>MyUser(
    id: json[userID],
    name: json[userName],
    phone: json[userPhone],
    password: json[userPassword],
    state: json[userState],
    address: json[userAddress],
  );

  MyUser fromFirebase(){
    id = document?.id;
    name = document?[userName].toString();
    phone = document?[userPhone].toString();
    password = document?[userPassword].toString();
    state = document?[userState].toString();
    address = document?[userAddress].toString();
    return this;
  }

  Map<String, String?> toMap(){
    return{
      userID: id,
      userName: name,
      userPhone: phone,
      userPassword: password,
      userState: state,
    };
  }

}