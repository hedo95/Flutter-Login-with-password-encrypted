import 'package:flutter/material.dart';
import 'package:login_password_encrypted/logic/BO/BO.dart';
import 'package:login_password_encrypted/logic/DAO/DAO.dart';
import 'package:login_password_encrypted/logic/models/customer.dart';
import 'package:login_password_encrypted/logic/models/mysql.dart';
import 'package:provider/provider.dart';

import 'newcustomer.dart';

class Login extends StatefulWidget {
  // Passwords are "12345678". They are encrypted at database.
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  List<Customer> customers = [];
  var dao = new DAO();

  Widget titleContainer(String title) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ));
  }

  Widget loginContainer() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Log in',
          style: TextStyle(fontSize: 20),
        ));
  }

  passwordiconOnpressed() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
  
  Widget forgotPasswordButton() {
    return FlatButton(
      onPressed: () {
        //forgot password screen
      },
      textColor: Colors.orange,
      child: Text('Forgot Password'),
    );
  }

  loginbuttononPressed() {
    if (customers.any((item) => item.username == usernameController.text)) {
      Customer customer = customers
          .firstWhere((item) => item.username == usernameController.text);
      if (customer.passwordVerify(passwordController.text)) {
        // Login App, you're in!
        openInfoDialog(context, 'User detected',
            "You're in! App gets started here with the current user");
      } else {
        // Incorrect password
        openInfoDialog(context, 'Invalid data', 'Your password is not correct');
      }
    } else {
      // User does not exist
      openInfoDialog(context, 'Invalid data', 'Make sure your username is correct');
    }
    print(usernameController.text);
    print(passwordController.text);
  }

  signUponPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Newcustomer()))
        .then((newcustomer) {
      if (newcustomer != null) {
        dao.insertCustomer(newcustomer as Customer).then((_) {
          dao.db.getConnection().then((conn) {
            String sql = 'select id from company.customer where username = ?;';
            conn.query(sql, [newcustomer.username]).then((results) {
              for (var row in results) {
                int id = row[0];
                newcustomer.id = id;
                setState(() {
                  customers.add(newcustomer);
                });
              }
              conn.close();
            });
          });
        });
      }
    });
  }

  Widget signupRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Does not have account?'),
          flatButton('Sign Up', fontSize: 18, onPressed: signUponPressed)
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      customers = Provider.of<List<Customer>>(context);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                titleContainer('Company'),
                loginContainer(),
                textfield('User name', usernameController, false,
                    outlineBorder: true),
                SizedBox(height: 20),
                passwordTextBox(passwordController, hidePassword, passwordiconOnpressed),
                forgotPasswordButton(),
                longButton(loginbuttononPressed, 'Login', customers: customers),
                signupRow(),
              ],
            )));
  }
}
