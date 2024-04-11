import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class ShiftsLocalProvider {
  final SQLiteService dataBaseSQLite = Get.find<SQLiteService>();

  Future<Response> createShift(Shift body) async {
    Response response;
    final route = ApiRoutes.SHIFT;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...body.toLocalDatabaseJson(),
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current shift in the local database
    await dataBaseSQLite.updateTable(
        DatabaseTables.currentShift, body.toLocalDatabaseJson());

    //Then we obtain the current shift from the local database
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentShift);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Create Shift Success',
        data: data.first["id"] != null ? data.firstOrNull : null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getCurrentShift() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentShift);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get Current Shift Success',
        data: data.first["id"] != null ? data.firstOrNull : null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> finishShift() async {
    Response response;

    final route = ApiRoutes.FINISH_SHIFT;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...Shift.nullShift().toJson(),
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we update the current shift in the local database
    await dataBaseSQLite.updateTable(
      DatabaseTables.currentShift,
      Shift.nullShift().toJson(),
    );

    //Then we obtain the current shift from the local database
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentShift);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Finished Shift Success',
        data: data.first["id"] != null ? data.firstOrNull : null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  void populateTable(dynamic data) {
    if (data == null) {
      dataBaseSQLite.updateTable(
        DatabaseTables.currentShift,
        Shift.nullShift().toJson(),
      );
    } else {
      dataBaseSQLite.updateTable(
        DatabaseTables.currentShift,
        data,
      );
    }
  }
}
