import 'package:onax_app/src/repositories/models/companyManModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

class CompanyMenSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(CompanyManModel companyMan) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO companyMen (id, customer_id, name)"
          "VALUES (?,?,?)",
          [
            companyMan.id,
            companyMan.customerId,
            companyMan.name,
          ]);
      print('company man inserted => $res => ${companyMan.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get all company man
  getCompanyMenSQLByCostumer(int costumer) async {
    try {
      List<CompanyManModel> listCompanyMan = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.query("companyMen",
          where: "customer_id = ?", whereArgs: [costumer]);
      //await db?.rawQuery("SELECT id, customer_id, name FROM companyMen");

      listCompanyMan = res!.isNotEmpty
          ? res.map((e) => CompanyManModel.fromJson(e)).toList()
          : [];
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': listCompanyMan,
      };
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //get all company man
  getCompanyMenSQL() async {
    try {
      List<CompanyManModel> listCompanyMan = [];
      final db = await DataBaseSQLite.db;
      var res =
          //await db?.query("companyMen",
          //  where: "customer_id = ?", whereArgs: [costumer]);
          await db?.rawQuery("SELECT id, customer_id, name FROM companyMen");

      listCompanyMan = res!.isNotEmpty
          ? res.map((e) => CompanyManModel.fromJson(e)).toList()
          : [];
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': listCompanyMan,
      };
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE company men
  trucateCompanyMen() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('companyMen');
      print('company men dropped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
