import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:onax_app/src/repositories/models/locationModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class LocationSQL {
  DataBaseSQLite con = DataBaseSQLite();
  final GlobalApi api = GlobalApi();

  createLocation(Map<String, dynamic> location) async {
    try {
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO location ( latitude, longitude ,speed, status , ticket_id , worker_id , init_date , end_date )"
          "VALUES (?,?,?,?,?,?,?,?)",
          [
            location['latitude'],
            location['longitude'],
            location['speed'],
            location['status'],
            location['ticket_id'],
            location['worker_id'],
            formatDate,
            '',
          ]);
      print('location inserted => $res');

      return {
        'statusCode': 200,
        'success': true,
        // 'data': {'ticketID': tickets.id}
      };
    } catch (e) {
      print(e.toString());
    }
  }

  updateLastLocation(Map<String, dynamic> location) async {
    try {
      Map<String, dynamic> result;
      final db = await DataBaseSQLite.db;
      var res = await db
          //add new condition if arrived or depart to for update
          ?.rawQuery("SELECT * FROM location where init_date != '' LIMIT 1 ");
      if (res!.isNotEmpty) {
        late DateTime date = DateTime.now().toUtc();
        String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
        var res = await db!.rawUpdate('UPDATE location set end_date = ?', [
          formatDate,
        ]);
        if (res == 1) {
          //create new register
          await createLocation(location);
        } else {
          return {
            'statusCode': 200,
            'success': false,
          };
        }
      } else {
        //Create new
        await createLocation(location);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  uploadToServer() async {
    try {
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      List<LocationModel> location;
      Map<String, dynamic> result;
      final db = await DataBaseSQLite.db;
      var res = await db
          //add new condition if arrived or depart to for update
          ?.rawQuery("SELECT * FROM location where end_date != ''  ");
      if (res!.isNotEmpty) {
        location = res.map((e) => LocationModel.fromJson(e)).toList();
        int count = 0;
        for (var element in location) {
          Map body = {
            'latitude': element.latitude,
            'longitude': element.longitude,
            'status': element.status,
            'speed': element.speed,
            'ticket_id': element.ticketId,
            'worker_id': element.workerId,
            'init_date': element.initDate,
            'end_date': element.endDate,
          };
          final String urlApi = element.id == 0
              ? '${api.api}/${api.updateOrStoreTicket}'
              : '${api.api}/updateDriverLocation';
          final response = await http.post(Uri.parse(urlApi),
              headers: header, body: json.encode(body));

          Map<String, dynamic> decodeResp = json.decode(response.body);
          if (response.statusCode == 200 && decodeResp['success'] == true) {
            count++;
          } else {
            print('No location with id = ${element.id}  upload to server');
          }
        }
        if (count == location.length) {
          await trucateLocations();
          print('All location are uploades intoServer');
        } else {
          print('All location are not uploaded in the server');
        }
      } else {
        //
        location = [];
        print('Not locations to upload');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateLocations() async {
    try {
      final db = await DataBaseSQLite.db;
      var res =
          await db?.rawQuery("DELETE FROM location where  end_date != '' ");

      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //END CLASS
}
