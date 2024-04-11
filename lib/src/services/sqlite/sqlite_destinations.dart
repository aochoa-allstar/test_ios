import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class DestinationsSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(DestinyOriginModel destination) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO destinations (id,name)"
          "VALUES (?,?)",
          [
            destination.id,
            destination.name,
          ]);
      print('destinations inserted => $res => ${destination.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getOriginsSQL() async {
    try {
      List<DestinyOriginModel> listDestinations = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT id, name FROM destinations");

      listDestinations = res!.isNotEmpty
          ? res.map((e) => DestinyOriginModel.fromJson(e)).toList()
          : [];
      Map result;
      if (listDestinations.isNotEmpty) {
        result = {
          'statusCode': 200,
          'success': true,
          'data': listDestinations,
        };
      } else {
        result = {
          'statusCode': 200,
          'success': false,
          'data': null,
        };
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateOrigins() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('destinations');
      print('destinations droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
