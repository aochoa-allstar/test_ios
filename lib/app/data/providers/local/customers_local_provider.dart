import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class CustomersLocalProvider {
  final SQLiteService dataBaseSQLite = Get.find<SQLiteService>();

  Future<Response> getCustomers() async {
    final String query = '''
  SELECT DISTINCT
    ${DatabaseTables.customers.tableName}.*,
    ${DatabaseTables.customersPivot.tableName}.company_id,
    ${DatabaseTables.customersPivot.tableName}.company_created_at,
    ${DatabaseTables.customersPivot.tableName}.company_updated_at
  FROM ${DatabaseTables.customers.tableName}
  LEFT JOIN ${DatabaseTables.customersPivot.tableName} ON ${DatabaseTables.customers.tableName}.id = ${DatabaseTables.customersPivot.tableName}.customer_id
  ''';

    final dataBaseResponse = await dataBaseSQLite.getTableByRawQuery(query);
    var data = dataBaseResponse['data'] as List<Map<String, dynamic>>;
    var editableData = data.map((element) {
      return {
        ...element,
        'pivot': {
          'company_id': element['company_id'],
          'created_at': element['company_created_at'],
          'updated_at': element['company_updated_at'],
        },
      }
        ..remove('company_id')
        ..remove('company_created_at')
        ..remove('company_updated_at');
    }).toList();

    final response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: dataBaseResponse['success'],
        message: 'Offline Get All Projects Success',
        data: editableData.isNotEmpty ? editableData : [],
      ),
    );

    responseNotifier(null, response);

    return response;
  }
}
