import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:onax_app/src/repositories/models/shiftModel.dart';

import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class ShiftSQL {
  DataBaseSQLite con = DataBaseSQLite();
  final GlobalApi api = GlobalApi();
  //download info.
  insertShiftFromServerSQL(ShiftModel shift) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO shift ( id ,worker_id ,  start_time ,  end_time ,  equipment_id ,  helper_id ,  helper2_id ,  helper3_id ,  active, temId,worker_type_id  )"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          [
            shift.id,
            shift.workerId,
            shift.startTime,
            shift.endTime,
            shift.equipmentId,
            shift.helper,
            shift.helper2,
            shift.helper3,
            shift.active,
            shift.temId,
            shift.worker_type_id,
          ]);
      print('shift inserted => $res => ${shift.id}');

      return {
        'statusCode': 200,
        'success': true,
        'data': {'shiftID': shift.id}
      };
    } catch (e) {
      print(e.toString());
    }
  }

  insertShiftFromAppSQL(Map body) async {
    try {
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO shift ( id ,worker_id ,  start_time ,  end_time ,  equipment_id ,  helper_id ,  helper2_id ,  helper3_id ,  active,temId,worker_type_id  )"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          [
            0,
            body['worker_id'],
            formatDate,
            body['end_time'],
            body['equipment_id'],
            body['helper_id'],
            body['helper2_id'],
            body['helper3_id'],
            body['active'],
            body['temId'],
            body['worker_type_id'],
          ]);
      print('shift inserted => $res');

      return {
        'statusCode': 200,
        'success': true,
        'data': {'shiftID': res}
      };
    } catch (e) {
      print(e.toString());
    }
  }

  getActiveShiftSQL(int id) async {
    try {
      var shift;
      var result;
      final db = await DataBaseSQLite.db;
      var res = await db?.query("shift",
          where: "active = ?  and idKey = ?", whereArgs: [1, id]);

      if (res!.isNotEmpty) {
        //shiftsFinished

        shift = ShiftModel.fromJson(res[0]);
        result = {
          'statusCode': 200,
          'success': true,
          'data': shift,
        };
      } else {
        var res2 = await db?.query("shift",
            where: "active = ?  and id = ?", whereArgs: [1, id]);
        if (res2!.isNotEmpty) {
          //shiftsFinished

          shift = ShiftModel.fromJson(res2[0]);
          result = {
            'statusCode': 200,
            'success': true,
            'data': shift,
          };
        } else {
          shift = null;
          result = {
            'statusCode': 200,
            'success': false,
            'data': shift,
          };
        }
        // shift = null;
        // result = {
        //   'statusCode': 200,
        //   'success': false,
        //   'data': shift,
        // };
      }

      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getENDShiftSQL(int id) async {
    try {
      var shift;
      var result;
      final db = await DataBaseSQLite.db;
      var res = await db?.query("shift", where: "idKey = ?", whereArgs: [id]);

      if (res!.isNotEmpty) {
        //shiftsFinished

        shift = ShiftModel.fromJson(res[0]);
        result = {
          'statusCode': 200,
          'success': true,
          'data': shift,
        };
      } else {
        var res2 = await db?.query("shift", where: " id = ?", whereArgs: [id]);
        if (res2!.isNotEmpty) {
          //shiftsFinished

          shift = ShiftModel.fromJson(res2[0]);
          result = {
            'statusCode': 200,
            'success': true,
            'data': shift,
          };
        } else {
          shift = null;
          result = {
            'statusCode': 200,
            'success': false,
            'data': shift,
          };
        }
        // shift = null;
        // result = {
        //   'statusCode': 200,
        //   'success': false,
        //   'data': shift,
        // };
      }

      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //updateFinishedTicketSQL()
  finishShiftSQL(int shiftId) async {
    try {
      final db = await DataBaseSQLite.db;
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      var res = await db!.rawUpdate(
          'UPDATE shift set end_time = ?, active = ?  WHERE  idKey = ?', [
        formatDate,
        0,
        shiftId,
      ]);
      if (res == 1) {
        var result = await getENDShiftSQL(shiftId);
        return result;
        //return {'statusCode': 200, 'success': true};
      } else {
        var res2 = await db.rawUpdate(
            'UPDATE shift set end_time = ?, active = ?  WHERE  id = ?', [
          formatDate,
          0,
          shiftId,
        ]);
        if (res2 == 1) {
          var result = await getENDShiftSQL(shiftId);
          return result;
        } else {
          return {
            'statusCode': 200,
            'success': false,
            'data': null,
          };
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  uploadShiftsToServer() async {
    try {
      final String urlApi = '${api.api}/${api.newShift}';
      print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      // late DateTime date = DateTime.now().toUtc();
      // String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);

      List<ShiftModel> shift;
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery(
          "SELECT * FROM shift where active = 1"); //"SELECT * FROM shift where end_time <> null "
      if (res!.isNotEmpty) {
        shift = res.map((e) => ShiftModel.fromJson(e)).toList();
        int count = 0;
        for (var element in shift) {
          Map body = {
            'id': element.id,
            'worker_id': element.workerId,
            'start_time': element.startTime,
            'end_time': element.endTime,
            'equipment_id': element.equipmentId,
            'helper_id': element.helper,
            'helper2_id': element.helper2,
            'helper3_id': element.helper3,
            'active': element.active,
            'temId': 't-${element.idKey}',
            'worker_type_id': element.worker_type_id,
          };
          if (element.id == 0) {
            final response = await http.post(Uri.parse(urlApi),
                headers: header, body: json.encode(body));
            Map<String, dynamic> decodeResp = json.decode(response.body);
            if (response.statusCode == 200 && decodeResp['success'] == true) {
              count++;
            } else {
              print('No shift with id = ${element.id}  upload to server');
            }
          }
        }
        if (count == shift.length) {
          await truncateShifts();
          print('All shift are uploades intoServer');
        } else {
          print('All shift are not uploaded in the server');
        }
      } else {
        shift = [];
        print('Not shift to upload');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  truncateShifts() async {
    ////db?.delete("shift", where: "active = ?", whereArgs: [0]);
    try {
      final db = await DataBaseSQLite.db; //
      var res = await db?.delete("shift");
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
