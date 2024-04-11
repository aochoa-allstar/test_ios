import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class DriverLocationsLocalProvider {
  final SQLiteService dataBaseSQLite = Get.find<SQLiteService>();

  Future<Response> createDriverLocation(Map<String, dynamic> body) async {
    Response response;

    final route = ApiRoutes.DRIVER_LOCATIONS;
    //First we insert the petition into the sync table
    await dataBaseSQLite.populateSyncTable(route, {
      ...body,
      "local_date": DateTime.now().toIso8601String(),
    });

    response = Response(
      statusCode: HttpStatus.ok,
      body: ApiResponse(
        success: true,
        message: 'Offline Sent Driver Location Success',
        data: {},
      ),
    );

    responseNotifier(null, response);

    return response;
  }
}
