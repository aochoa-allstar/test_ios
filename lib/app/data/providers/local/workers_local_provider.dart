import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class WorkersLocalProvider {
  SQLiteService dataBaseSQLite = Get.find();

  Future<Response> getHelpers() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.helpers);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Helpers Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getSupervisors() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.supervisors);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Supervisors Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getWorkerTypes() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.workerTypes);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Worker Types Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getWorkerById(int id) async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.currentWorker);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get Current Ticket Success',
        data: data.first["id"] != null ? data.firstOrNull : null,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  void populateCurrentWorker(dynamic data) {
    if (data == null) {
      dataBaseSQLite.updateTable(
        DatabaseTables.currentTicket,
        UserWorker().toJson(),
      );
    } else {
      dataBaseSQLite.updateTable(
        DatabaseTables.currentWorker,
        data,
      );
    }
  }

  void populateHelpers(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.helpers);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.helpers, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.helpers, data);
    }
  }

  void populateSupervisors(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.supervisors);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.supervisors, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.supervisors, data);
    }
  }

  void populateWorkerTypes(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.workerTypes);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.workerTypes, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.workerTypes, data);
    }
  }
}
