import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class ProjectsLocalProvider {
  final SQLiteService dataBaseSQLite = Get.find<SQLiteService>();

  Future<Response> createProject() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false, message: 'Offline Create Project Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getAllProjects() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.projects);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Projects Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }
}
