import 'package:login_password_encrypted/logic/models/customer.dart';
import 'package:login_password_encrypted/logic/models/mysql.dart';

/// DAO == Data Access Object
/// Here we got the connection between the app and the database

class DAO {
  static Mysql db = new Mysql();

  DAO();

  Future<List<Customer>> getCustomers() async {
    List<Customer> result = [];
    db.getConnection().then((conn) {
      String sql = 'select * from company.customer;';
      conn.query(sql).then((results) {
        for (var row in results) {
          result.add(
              new Customer(row[1], row[2], row[3], row[4], row[5], id: row[0]));
        }
      });
      conn.close();
    });
    return result;
  }

  // Return the id given by database
  int insertCustomer(Customer customer) {
    int id = -1;
    List data = [
      customer.username,
      customer.name,
      customer.lastname,
      customer.mail,
      customer.hash
    ];
    db.getConnection().then((conn) {
      String sql =
          'insert into company.customer (username, name, lastname, mail, password) values(?, ?, ?, ?, ?)';
      conn.query(sql, data).catchError((error) {
        print('$error');
      });
      String sql2 =
          'select id from company.customer where username = ? and name = ? and lastname = ? and mail = ? and password = ?; ';
      conn.query(sql2, data).then((results) {
        for (var row in results) {
          id = row[0];
        }
      }, onError: (error) {
        print('$error');
      });
      conn.close();
    });
    return id;
  }
}
