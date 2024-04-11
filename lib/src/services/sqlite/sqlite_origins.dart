import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class OriginsSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(DestinyOriginModel origin) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO origins (id,name)"
          "VALUES (?,?)",
          [
            origin.id,
            origin.name,
          ]);
      print('origins inserted => $res => ${origin.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getOriginsSQL() async {
    try {
      List<DestinyOriginModel> listOrigin = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT id, name FROM origins");

      listOrigin = res!.isNotEmpty
          ? res.map((e) => DestinyOriginModel.fromJson(e)).toList()
          : [];
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': listOrigin,
      };
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateOrigins() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('origins');
      print('origins droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
