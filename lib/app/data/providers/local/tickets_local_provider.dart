import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class TicketsLocalProvider {
  final SQLiteService dataBaseSQLite = Get.find<SQLiteService>();

  Future<Response> createTicket(Map<String, dynamic> rawBody) async {
    Response response;
    final route = ApiRoutes.TICKET;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...Ticket.toLocalDataBaseJson(rawBody),
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current ticket in the local database
    await dataBaseSQLite.updateTable(
        DatabaseTables.currentTicket, Ticket.toLocalDataBaseJson(rawBody));

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: true,
        message: 'Offline Create Ticket Success',
        data: null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getTicketHistory() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.finishedTickets);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Read Finished Ticket success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getTicketDetails() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false,
            message: 'Offline Read Ticket details Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getActiveTicket() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentTicket);
    final allData = dataBaseResponse['data'] as List<Map<String, dynamic>>;
    final rawData = allData.first["id"] != null ? allData.firstOrNull : null;
    var data = null;
    if (rawData != null) {
      data = Ticket.fromLocalDataBaseJson(rawData);
    }

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get Current Ticket Success',
        data: data,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> updateTicketDepart(Map<String, dynamic> body) async {
    Response response;
    final route = ApiRoutes.UPDATE_TICKET_DEPART;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...body,
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current ticket in the local database
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentTicket);
    final allData = dataBaseResponse['data'] as List<Map<String, dynamic>>;
    var rawData = allData.first["id"] != null ? allData.firstOrNull : null;
    Map<String, dynamic> data = Map.from(rawData!);
    data["depart_timestamp"] = DateTime.now().toIso8601String();

    //Then we update the current ticket in the local database
    await dataBaseSQLite.updateTable(DatabaseTables.currentTicket, data);

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Update Ticket Success',
        data: Ticket.fromLocalDataBaseJson(data),
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> updateTicketArrive(Map<String, dynamic> body) async {
    Response response;
    final route = ApiRoutes.UPDATE_TICKET_ARRIVE;

    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...body,
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current ticket in the local database
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentTicket);
    final allData = dataBaseResponse['data'] as List<Map<String, dynamic>>;
    var rawData = allData.first["id"] != null ? allData.firstOrNull : null;
    Map<String, dynamic> data = Map.from(rawData!);
    data["arrived_photo"] = body["arrived_photo"];
    data["arrived_timestamp"] = DateTime.now().toIso8601String();

    //Then we update the current ticket in the local database
    await dataBaseSQLite.updateTable(DatabaseTables.currentTicket, data);

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
          success: dataBaseResponse['success'],
          message: 'Offline Update Ticket Not Implemented',
          data: Ticket.fromLocalDataBaseJson(data)),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> updateTicketFinish(Map<String, dynamic> body) async {
    Response response;
    final route = ApiRoutes.UPDATE_TICKET_FINISH;

    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...body,
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current ticket in the local database
    await dataBaseSQLite.updateTable(
      DatabaseTables.currentTicket,
      Ticket.nullTicket().toJson(),
    );

    //And remove JSAs related to the current ticket
    await dataBaseSQLite.deleteRowInTable(
      DatabaseTables.jsas,
      body["id"] ?? 0,
      'ticket_id = ?',
    );

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: true,
        message: 'Offline Finish Ticket Success',
        data: null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> signTicket() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false, message: 'Offline Sign Ticket Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  void populateCurrentTicketTable(dynamic data) {
    if (data == null) {
      dataBaseSQLite.updateTable(
        DatabaseTables.currentTicket,
        Ticket.nullTicket().toJson(),
      );
    } else {
      final ticketData = Ticket.toLocalDataBaseJson(data);
      dataBaseSQLite.updateTable(
        DatabaseTables.currentTicket,
        ticketData,
      );
    }
  }

  void populateFinishedTicketsTable(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.finishedTickets);
    if (data is List) {
      data.forEach((e) =>
          dataBaseSQLite.insertIntoTable(DatabaseTables.finishedTickets, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.finishedTickets, data);
    }
  }
}
