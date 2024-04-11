import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class EquipmentsLocalProvider {
  SQLiteService dataBaseSQLite = Get.find();

  Future<Response> getAllEquipments() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.trucks);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Equipments Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getTrucks() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.trucks);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Trucks Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getTrailers() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false,
            message: 'Offline Get All Trailers Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  void populateTrucksTable(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.trucks);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.trucks, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.trucks, data);
    }
  }

  void populateEquipmentsTable(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.equipments);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.equipments, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.equipments, data);
    }
  }
}
