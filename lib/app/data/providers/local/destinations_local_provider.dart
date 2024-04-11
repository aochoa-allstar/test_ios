import 'dart:io';

import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';

class DestinationsLocalProvider {
  Future<Response> createDestination() async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Create Destination Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getAllDestinations() async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Get All Destinations Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }

  Future<Response> getDestination() async {
    Response response;
    response = Response(
      statusCode: HttpStatus.notImplemented,
      body: ApiResponse(success: false, message: 'Offline Get Destination Not Implemented')
    );

    responseNotifier(null, response);

    return response;
  }
}
