import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;
import '../../repositories/models/desty_origin_Model.dart';

class TicketsSQL {
  DataBaseSQLite con = DataBaseSQLite();
  final GlobalApi api = GlobalApi();
  //download info.
  insertTicketsSQL(TicketModel tickets) async {
    try {
      late DateTime date = DateTime.parse(tickets.date);
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO tickets ( id, shift_id , customer, customer_id , destination_id , project_id , date , equipment_id , worker_id , helper_id , helper2_id , helper3_id , depart_timestamp , arrived_timestamp , finished_timestamp ,arrived_photo ,finished_photo ,description,work_hours,worker_type_id)"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            tickets.id,
            tickets.shiftId,
            tickets.customer,
            tickets.customerId,
            tickets.destinationId,
            tickets.projectId,
            formatDate,
            tickets.equipmentId,
            tickets.workerId,
            tickets.helperId,
            tickets.helperId2,
            tickets.helperId3,
            tickets.deparmentTimesTimep,
            tickets.arrivedTimesTimep,
            tickets.finishedTimesTimep,
            tickets.arrivedPhoto,
            tickets.finishedPhoto,
            tickets.descrition,
            tickets.work_hours,
            tickets.worker_type_id,
          ]);
      print('tickets inserted => $res => ${tickets.id}');

      return {
        'statusCode': 200,
        'success': true,
        'data': {'ticketID': tickets.id}
      };
    } catch (e) {
      print(e.toString());
    }
  }

  insertTicketFromAppSQL(Map body) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO tickets ( id ,shift_id , company_man_id, customer, customer_id , destination_id , project_id , date , equipment_id , worker_id , helper_id , helper2_id , helper3_id , depart_timestamp , arrived_timestamp , finished_timestamp ,arrived_photo ,finished_photo ,description,worker_type_id)"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            null,
            body['shift_id'],
            body['company_man_id'],
            body['customer'],
            body['customer_id'],
            body['destination_id'],
            body['project_id'],
            body['date'],
            body['equipment_id'], //review how to get this value from the app
            body['worker_id'],
            body['helper_id'],
            body['helper2_id'],
            body['helper3_id'],
            body['depart_timestamp'],
            body['arrived_timestamp'],
            body['finished_timestamp'],
            body['arrived_photo'],
            body['finished_photo'],
            body['description'],
            body['worker_type_id'],
          ]);
      print('tickets inserted => $res ');

      return {
        'statusCode': 200,
        'success': true,
        'data': {'ticketID': res}
      };
    } catch (e) {
      print(e.toString());
    }
  }

  //ticketsFinished
  insertTicketsFinishedSQL(TicketModel tickets) async {
    try {
      late DateTime date = DateTime.parse(tickets.date);
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO ticketsFinished (  id,shift_id , customer, customer_id , destination_id , project_id , date , equipment_id , worker_id , helper_id , helper2_id , helper3_id , depart_timestamp , arrived_timestamp , finished_timestamp ,arrived_photo ,finished_photo ,description,work_hours,worker_type_id)"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            tickets.id,
            tickets.shiftId,
            tickets.customer,
            tickets.customerId,
            tickets.destinationId,
            tickets.projectId,
            formatDate,
            tickets.equipmentId,
            tickets.workerId,
            tickets.helperId,
            tickets.helperId2,
            tickets.helperId3,
            tickets.deparmentTimesTimep,
            tickets.arrivedTimesTimep,
            tickets.finishedTimesTimep,
            tickets.arrivedPhoto,
            tickets.finishedPhoto,
            tickets.descrition,
            tickets.work_hours,
            tickets.worker_type_id,
          ]);
      print('tickets inserted => $res => ${tickets.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allTicketFiniser
  getPrevTicketsFinishedsSQL() async {
    try {
      List<TicketModel> listTickets = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery(
          "SELECT * FROM ticketsFinished Where finished_timestamp != '' Order by id desc");

      listTickets = res!.isNotEmpty
          ? res.map((e) => TicketModel.fromJson(e)).toList()
          : [];
      Map data;
      if (listTickets.isNotEmpty) {
        data = {
          'statusCode': 200,
          'success': true,
          'data': listTickets,
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

  getActiveTicketSQL(int id) async {
    try {
      TicketModel? ticket;
      Map<String, dynamic> result;
      final db = await DataBaseSQLite.db;
      var res =
          await db?.query("tickets", where: " idKey = ?", whereArgs: [id]);

      if (res!.isNotEmpty) {
        //ticketsFinished

        ticket = TicketModel.fromJson(res[0]);
        result = {
          'statusCode': 200,
          'success': true,
          'data': ticket,
        };
      } else {
        //and finished_timestamp = ''
        var res2 =
            await db?.query("tickets", where: " id = ?  ", whereArgs: [id]);
        if (res2!.isNotEmpty) {
          ticket = TicketModel.fromJson(res2[0]);
          result = {
            'statusCode': 200,
            'success': true,
            'data': ticket,
          };
        } else {
          ticket = null;
          result = {
            'statusCode': 200,
            'success': false,
            'data': ticket,
          };
        }
        //ticket = null;

      }

      return result;
    } catch (e) {
      print(e.toString());
      return {
        'statusCode': 500,
        'success': false,
        'data': null,
      };
    }
  }

  getAllTicketsSQLITE() async {
    try {
      List<TicketModel> listTickets = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.query("tickets");
      listTickets = res!.isNotEmpty
          ? res.map((e) => TicketModel.fromJson(e)).toList()
          : [];
      print(listTickets);
    } catch (e) {
      print(e.toString());
    }
  }

  //updateDepartTime
  updateDepartTimeSQL(int ticketId) async {
    try {
      final db = await DataBaseSQLite.db;
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      var res = await db!.rawUpdate(
          'UPDATE tickets set depart_timestamp = ? WHERE idKey = ?', [
        formatDate,
        ticketId,
      ]);

      if (res == 1) {
        var result = await getActiveTicketSQL(ticketId);
        return result;
      } else {
        //
        var res2 = await db
            .rawUpdate('UPDATE tickets set depart_timestamp = ? WHERE id = ?', [
          formatDate,
          ticketId,
        ]);
        if (res2 == 1) {
          var result2 = await getActiveTicketSQL(ticketId);
          return result2;
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

  //updateArrivedInfoTicket
  updateArrivedInfoTicketSQL(
      int ticketId, String arrived_photo, int destinationId) async {
    try {
      final db = await DataBaseSQLite.db;
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      var res = await db!.rawUpdate(
          'UPDATE tickets set arrived_timestamp = ?, arrived_photo = ?, destination_id = ? WHERE idKey = ?',
          [
            formatDate,
            arrived_photo,
            destinationId,
            ticketId,
          ]);

      if (res == 1) {
        var result = await getActiveTicketSQL(ticketId);
        return result;
      } else {
        var res2 = await db.rawUpdate(
            'UPDATE tickets set arrived_timestamp = ?, arrived_photo = ?, destination_id = ? WHERE id = ?',
            [
              formatDate,
              arrived_photo,
              destinationId,
              ticketId,
            ]);
        if (res2 == 1) {
          var result = await getActiveTicketSQL(ticketId);
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

  //updateFinishedTicketSQL()
  updateFinishedTicketSQL(
      int ticketID, String finishPhoto, String description) async {
    try {
      final db = await DataBaseSQLite.db;
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      var res = await db!.rawUpdate(
          'UPDATE tickets set finished_timestamp = ?, finished_photo = ?, description = ? WHERE  idKey = ?',
          [
            formatDate,
            finishPhoto,
            description,
            ticketID,
          ]);
      if (res == 1) {
        var result = await getActiveTicketSQL(ticketID);
        return result;
      } else {
        var res2 = await db.rawUpdate(
            'UPDATE tickets set finished_timestamp = ?, finished_photo = ?, description = ? WHERE  id = ?',
            [
              formatDate,
              finishPhoto,
              description,
              ticketID,
            ]);
        if (res2 == 1) {
          var result = await getActiveTicketSQL(ticketID);
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

  uploadTicketToServerAllFinisheds() async {
    try {
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      //updateTicketFromAppToServer

      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);

      List<TicketModel> ticket;
      final db = await DataBaseSQLite.db;
      var res = await db
          //add new condition if arrived or depart to for update
          ?.rawQuery("SELECT * FROM tickets where finished_timestamp != '' ");
      if (res!.isNotEmpty) {
        ticket = res.map((e) => TicketModel.fromJson(e)).toList();
        int count = 0;
        for (var element in ticket) {
          Map body = {
            'id': element.id,
            'shift_id': element.shiftId,
            'customer': element.customer,
            'customer_id': element.customerId,
            'destination_id': element.destinationId,
            'project_id': element.projectId,
            'date': formatDate,
            'equipment_id': element.equipmentId,
            'worker_id': AccountPrefs.idUser,
            'helper_id': element.helperId,
            'helper2_id': element.helperId2,
            'helper3_id': element.helperId3,
            'depart_timestamp': element.deparmentTimesTimep,
            'arrived_timestamp': element.arrivedTimesTimep,
            'finished_timestamp': element.finishedTimesTimep,
            'arrived_photo': element.arrivedPhoto,
            'finished_photo': element.finishedPhoto,
            'description': element.descrition,
            'worker_type_id': element.worker_type_id,
          };
          final String urlApi = element.id == 0
              ? '${api.api}/${api.updateOrStoreTicket}'
              : '${api.api}/updateTicketFromAppToServer';
          final response = element.id == 0
              ? await http.post(Uri.parse(urlApi),
                  headers: header, body: json.encode(body))
              : await http.put(Uri.parse(urlApi),
                  headers: header, body: json.encode(body));
          Map<String, dynamic> decodeResp = json.decode(response.body);
          if (response.statusCode == 200 && decodeResp['success'] == true) {
            count++;
          } else {
            print('No ticket with id = ${element.id}  upload to server');
          }
        }
        if (count == ticket.length) {
          await trucateTicket();
          print('All tickets are uploades intoServer');
        } else {
          print('All tickets are not uploaded in the server');
        }
      } else {
        ticket = [];
        print('Not Tickets to upload');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateTicket() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db
          ?.rawQuery("DELETE FROM tickets where  finished_timestamp != '' ");
      //   var res = await db?.rawQuery('DROP TABLE tickets');

      //   //('tickets', where: 'finished_timestamp <> "" ');
      //   print('tickets droped');
      //   await db?.rawQuery('''
      //   CREATE TABLE IF NOT EXISTS tickets (
      //       idKey INTEGER PRIMARY KEY AUTOINCREMENT,
      //       id INTEGER,
      //      shift_id INTEGER,
      //     customer TEXT,
      //     customer_id INTEGER,
      //     destination_id INTEGER,
      //     project_id INTEGER,
      //     date TEXT,
      //     equipment_id INTEGER,
      //     worker_id INTEGER,
      //     helper_id INTEGER,
      //     helper2_id INTEGER,
      //     helper3_id INTEGER,
      //     depart_timestamp TEXT,
      //     arrived_timestamp TEXT,
      //     finished_timestamp TEXT,
      //     arrived_photo TEXT,
      //     finished_photo TEXT,
      //     description TEXT
      //   )
      // ''');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  trucateTicketFinisheds() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('ticketsFinished');
      print('ticketsFinished droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
