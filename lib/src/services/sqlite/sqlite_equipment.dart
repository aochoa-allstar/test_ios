import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

class EquipmentSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(EquipmentModel equipment) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO equipment ( id ,worker_id, number ,  type ,  plate,   vin,  make   , model ,  year , inactive)"
          "VALUES (?,?,?,?,?,?,?,?,?,?)",
          [
            equipment.id,
            equipment.workerId,
            equipment.name,
            equipment.type,
            equipment.plate,
            equipment.vin,
            equipment.make,
            equipment.model,
            equipment.year,
            equipment.inactive,
          ]);
      print('Equipment inserted => $res => ${equipment.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getALLEquipmentSQL() async {
    try {
      List<EquipmentModel> listTruck = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT * FROM equipment");

      listTruck = res!.isNotEmpty
          ? res.map((e) => EquipmentModel.fromJson(e)).toList()
          : [];
      Map data;
      if (listTruck.isNotEmpty) {
        data = {
          'statusCode': 200,
          'success': true,
          'data': listTruck,
        };
      } else {
        data = {
          'statusCode': 200,
          'success': false,
          'data': null,
        };
      }
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  //get TRUCKS or EQUIPMENTS
  getEquipmentTrucksSQL() async {
    try {
      List<EquipmentModel> listTruck = [];
      final db = await DataBaseSQLite.db;
      var res = await db
          ?.rawQuery("SELECT * FROM equipment Where type != 'trailers' ");

      listTruck = res!.isNotEmpty
          ? res.map((e) => EquipmentModel.fromJson(e)).toList()
          : [];
      Map data;
      if (listTruck.isNotEmpty) {
        data = {
          'statusCode': 200,
          'success': true,
          'data': listTruck,
        };
      } else {
        data = {
          'statusCode': 200,
          'success': false,
          'data': null,
        };
      }
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment TRAILERS
  getEquipmentTrailersSQL() async {
    try {
      List<EquipmentModel> listTrailers = [];
      final db = await DataBaseSQLite.db;
      var res = await db
          ?.rawQuery("SELECT * FROM equipment Where type = 'trailers' ");

      listTrailers = res!.isNotEmpty
          ? res.map((e) => EquipmentModel.fromJson(e)).toList()
          : [];
      Map data;
      if (listTrailers.isNotEmpty) {
        data = {
          'statusCode': 200,
          'success': true,
          'data': listTrailers,
        };
      } else {
        data = {
          'statusCode': 200,
          'success': false,
          'data': null,
        };
      }
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateEquipment() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('equipment');
      print('Equipment droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
