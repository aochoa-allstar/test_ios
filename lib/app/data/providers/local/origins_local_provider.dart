import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';

class OriginsLocalProvider {
  Future<Response> getOrigins() async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Get Origins Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }
}
