import 'package:password/password.dart';

class Customer {
  int id;
  String username, name, lastname, mail, hash;
  PBKDF2 algorithm;

  Customer(this.username, this.name, this.lastname, this.mail, String password, {this.id}){
    algorithm = new PBKDF2();
    hash = Password.hash(password, algorithm);
  } 

  Customer.def(){
    id = null;
    username = '';
    name = '';
    lastname = '';
    mail = '';
    hash = '';
  }

  passwordVerify(String password){
    return Password.verify(password,hash);
  }
}