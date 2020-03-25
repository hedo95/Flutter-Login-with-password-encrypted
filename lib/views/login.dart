import 'package:flutter/material.dart';
import 'package:login_password_encrypted/logic/BO/BO.dart';
import 'package:login_password_encrypted/logic/DAO/DAO.dart';
import 'package:login_password_encrypted/logic/models/customer.dart';
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

  Widget usernameTextfield(TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'User Name',
        ),
      ),
    );
  }

  Widget passwordTextfield(TextEditingController controller) {
    return TextField(
        obscureText: hidePassword,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            suffixIcon: IconButton(
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                })));
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
        openDialog(context, 'User detected',
            "You're in! App gets started here with the current user");
      } else {
        // Incorrect password
        openDialog(context, 'Invalid data', 'Your password is not correct');
      }
    } else {
      // User does not exist
      openDialog(context, 'Invalid data', 'Make sure your username is correct');
    }
    print(usernameController.text);
    print(passwordController.text);
  }

  Widget loginButton(List<Customer> customers) {
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {},
        ));
  }

  Widget signupButton() {
    return Container(
        child: Row(
      children: <Widget>[
        Text('Does not have account?'),
        InkWell(
          child: FlatButton(
            textColor: Colors.orange,
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Newcustomer()))
                  .then((newcustomer) {
                if (newcustomer != null) {
                  dao.insertCustomer(newcustomer as Customer);
                  int id = dao.getidfromCustomer(newcustomer as Customer);
                  newcustomer.id = id;
                  setState(() {
                    customers.add(newcustomer);
                  });
                }
              });
            },
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  @override
  Widget build(BuildContext context) {
    customers = Provider.of<List<Customer>>(context);
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
                passwordTextfield(passwordController),
                forgotPasswordButton(),
                longButton(loginbuttononPressed, 'Login', customers: customers),
                signupButton()
              ],
            )));
  }
}
