import 'package:amit_ecommerce/consonants.dart';

class RegistrationModel{
  String _name;
  String _password;
  String _email;

  String get name=>_name;
  String get password=>_password;
  String get email=>_email;

  RegistrationModel(this._email,this._password,this._name);



}