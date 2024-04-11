import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class CompanyMenLocalProvider {
  SQLiteService dataBaseSQLite = Get.find();

  Future<Response> createCompanyMan() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false,
            message: 'Offline Create Company Men Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getAllCompanyMen() async {
    final dataBaseResponse =
        await dataBaseSQLite.getTable(DatabaseTables.CompanyMen);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Company Men Success',
        data: data.isNotEmpty ? data : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getCompanyMenByCustomer() async {
    Response response;
    response = Response(
        statusCode: HttpStatus.notImplemented,
        body: ApiResponse(
            success: false,
            message: 'Offline Get Customer Company Men Not Implemented'));

    responseNotifier(null, response);

    return response;
  }

  void populateAllCompanyMen(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.CompanyMen);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.CompanyMen, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.CompanyMen, data);
    }
  }
}
