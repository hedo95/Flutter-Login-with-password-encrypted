import 'package:flutter/material.dart';
import 'package:login_password_encrypted/logic/models/customer.dart';
import 'package:provider/provider.dart';

import 'newcustomer.dart';

class Login extends StatefulWidget {
  // Passwords are "12345678". They are encrypted at database.
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  void openDialog(BuildContext context, String dialogContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text('Invalid data'),
            content: new Text(dialogContent),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Back'))
            ],
          );
        });
  }

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
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
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
                })),
      ),
    );
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

  Widget loginButton() {
    return Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: RaisedButton(
          textColor: Colors.white,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            print(nameController.text);
            print(passwordController.text);
          },
        ));
  }

  Widget signupButton() {
    return Container(
        child: Row(
      children: <Widget>[
        Text('Does not have account?'),
        FlatButton(
          textColor: Colors.orange,
          child: Text(
            'Sign up',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Newcustomer()));
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                titleContainer('Company'),
                loginContainer(),
                usernameTextfield(nameController),
                passwordTextfield(passwordController),
                forgotPasswordButton(),
                loginButton(), // kldj-34gb-gj89-45gd
                signupButton()
              ],
            )));
  }
}
