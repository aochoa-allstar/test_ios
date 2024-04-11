import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/ticketDescriptionsModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class TicketDescriptionSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(TicketDescriptionsModel ticketDescript) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO ticketDescription (id,name,name_spanish,`text`)"
          "VALUES (?,?,?,?)",
          [
            ticketDescript.id,
            ticketDescript.name,
            ticketDescript.spanishName,
            ticketDescript.descrition,
          ]);
      print('ticketDescripts inserted => $res => ${ticketDescript.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getTicketDescriptionsSQL() async {
    try {
      List<TicketDescriptionsModel> listDescriptions = [];
      final db = await DataBaseSQLite.db; //id, name,name_spanish, `text`
      var res = await db?.rawQuery("SELECT * FROM ticketDescription");

      listDescriptions = res!.isNotEmpty
          ? res.map((e) => TicketDescriptionsModel.fromJson(e)).toList()
          : [];
      Map result;
      if (listDescriptions.isNotEmpty) {
        result = {
          'statusCode': 200,
          'success': true,
          'data': listDescriptions,
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
  trucateTicketDescription() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('ticketDescription');
      print('origins droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
