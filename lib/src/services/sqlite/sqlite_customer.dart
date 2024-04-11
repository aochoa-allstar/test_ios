import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class CustomerSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(CustomerModel customer) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO customer (id,name)"
          "VALUES (?,?)",
          [
            customer.id,
            customer.name,
          ]);
      print('customers inserted => $res => ${customer.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getCustomersSQL() async {
    try {
      List<CustomerModel> listCustomer = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT id, name FROM customer");

      listCustomer = res!.isNotEmpty
          ? res.map((e) => CustomerModel.fromJson(e)).toList()
          : [];
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': listCustomer,
      };
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateCustomer() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('customer');
      print('origins droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
