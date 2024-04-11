import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/jsa_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class JSAsLocalProvider {
  SQLiteService dataBaseSQLite = Get.find();

  Future<Response> createJSA(Map<String, dynamic> data) async {
    Response response;
    final route = ApiRoutes.CREATE_JSA;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...data,
      "local_date": DateTime.now().toIso8601String(),
    });

    //Then we push a new JSA into the JSAS table
    await dataBaseSQLite.insertIntoTable(
        DatabaseTables.jsas, JSA.toLocalDataBaseJson(data));

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: true,
        message: 'Offline Create JSA Success',
        data: data,
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> signJSA() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false, message: 'Offline Sign JSA Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getJSAsByUser() async {
    final dataBaseResponse = await dataBaseSQLite.getTable(DatabaseTables.jsas);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;
    var editableData = data.map((element) {
      return {
        ...element,
        "project": {"name": element['project_name']},
      }..remove('project_name');
    }).toList();

    final decodedData = editableData.isNotEmpty
        ? editableData.map((e) => JSA.fromLocalDataBaseJson(e)).toList()
        : [];

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All JSAs By User Success',
        data: editableData.isNotEmpty ? decodedData : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  void populateAllJSAsByUser(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.jsas);
    if (data is List) {
      var editableData = data.map((element) {
        Map<String, dynamic> newData;
        newData = {
          ...element,
          "project_name": element['project']['name'],
        }..remove('project');
        return newData;
      }).toList();
      editableData.forEach(
        (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.jsas, e),
      );
    }
    if (data is Map) {
      dataBaseSQLite.insertIntoTable(
          DatabaseTables.jsas, data as Map<String, dynamic>);
    }
  }

  Future<Response> getPDF() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false, message: 'Offline Get PDF Not Implemented'));

    responseNotifier(null, response);

    return response;
  }
}
