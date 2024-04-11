import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';

class AuthLocalProvider {
  Future<Response> logIn(body, String? database) async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Log In Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> logOut(body) async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Log Out Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> recoverPassword(body) async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Password Recovery Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }
}
