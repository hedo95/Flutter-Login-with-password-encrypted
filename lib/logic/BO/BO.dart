/// BO == Bussiness Objects
/// Here we got what we want our business to do (Functions, widgets...)

import 'package:flutter/material.dart';
import 'package:login_password_encrypted/logic/models/customer.dart';

bool isNullOrEmpty(String str) {
  if (str.isEmpty || str == null || str.length == 0) {
    return true;
  } else {
    return false;
  }
}

void openDialog(
    BuildContext context, String dialogTitle, String dialogContent) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text(dialogTitle),
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

Widget textfield(
    String labeltext, TextEditingController controller, bool obscureText,
    {bool validate, bool outlineBorder = false}) {
  InputDecoration inputDecoration;
  if (validate != null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate != null && outlineBorder == true) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate == null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
    );
  } else {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
    );
  }
  return TextField(
    obscureText: obscureText,
    decoration: inputDecoration,
    controller: controller,
  );
}

Widget passwordTextBox(TextEditingController controller, bool hidePassword, Function onPressed) {
  return TextField(
      obscureText: hidePassword,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          suffixIcon: IconButton(
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: onPressed)));
}

Widget longButton(Function onPressed, String textButton,
    {List<Customer> customers}) {
  return Container(
      height: 50,
      child: RaisedButton(
          textColor: Colors.white,
          child: Text(
            textButton,
            style: TextStyle(fontSize: 18),
          ),
          onPressed: onPressed));
}

Widget flatButton(String text, {double fontSize = 15, Function onPressed}) {
  return InkWell(
      child: FlatButton(
          textColor: Colors.orange,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
          onPressed: onPressed));
}
