import 'package:password/password.dart';

class Customer {
  int id;
  String username, name, lastname, mail, hash;
  PBKDF2 algorithm;

  Customer(this.username, this.name, this.lastname, this.mail, String password){
    algorithm = new PBKDF2();
    hash = Password.hash(password, algorithm);
  } 

  Customer.db(this.id, this.username, this.name, this.lastname, this.mail, this.hash) {
    algorithm = new PBKDF2();
  }

  Customer.def(){
    id = null;
    username = '';
    name = '';
    lastname = '';
    mail = '';
    hash = '';
    algorithm = new PBKDF2();
  }

  bool passwordVerify(String password){
    return Password.verify(password,hash);
  }
}