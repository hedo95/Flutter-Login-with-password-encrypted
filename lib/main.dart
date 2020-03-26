import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/DAO/DAO.dart';
import 'logic/models/customer.dart';
import 'views/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var dao = DAO();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.fromFuture(dao.getCustomers()),
        builder: (context, response) {
          if (!response.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (response.hasError) {
            return Center(child: Text(response.error));
          } else {
            return MultiProvider(
                providers: [
                  Provider<List<Customer>>.value(
                    value: response.data,
                  )
                ],
                child: MaterialApp(
                    title: 'Login Screen',
                    theme: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.orange,
                        accentColor: Colors.orange),
                    home: Login()));
          }
        });
  }
}
