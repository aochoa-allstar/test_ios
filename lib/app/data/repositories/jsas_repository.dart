import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/jsa_model.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/providers/local/jsas_local_provider.dart';
import 'package:onax_app/app/data/providers/server/jsas_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/user_location_service.dart';
import 'package:http/http.dart' as http;

class JSAsRepository extends GetxController {
  JSAsRepository({required this.serverProvider, required this.localProvider});

  final JSAsServerProvider serverProvider;
  final JSAsLocalProvider localProvider;
  PreferencesService preferencesService = Get.find();

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  UserLocationService userLocationService = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return JSA.fromJson(data);
    if (data is List) return data.map((item) => JSA.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getJSAsByUser() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getJSAsByUser();
    } else {
      httpResponse = await serverProvider.getJSAsByUser();
      ApiResponse apiResponse = httpResponse.body;
      if (apiResponse.success != null && apiResponse.success!) {
        localProvider.populateAllJSAsByUser(apiResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<UserCoordinates> getLocation() async {
    final location = await userLocationService.getLocation();
    return UserCoordinates(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  Future<ApiResponse> createJSA(
    Map<String, dynamic> body,
  ) async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createJSA(body)
            : await serverProvider.createJSA(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> signJSA(
    int jsaId,
    String name,
    String signature,
  ) async {
    final body = {
      'jsas_id': jsaId,
      'name': name,
      'signature': signature,
    };
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.signJSA()
            : await serverProvider.signJSA(body);

    return decodeResponse(httpResponse);
  }

  //TODO: Correct this implementation
  Future<String?> getJSADetailsHtml(int jsaId) async {
    final Session session = await preferencesService.getSession();
    final token = session.sessionToken;
    final response = await http.get(
        Uri.parse('${ApiRoutes.BASE + ApiRoutes.VIEW_JSA_PDF}/${jsaId}/1'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token}',
        });
    if (response.statusCode == 200) {
      final String htmlContent = response.body;
      return htmlContent;
    } else {
      return null;
    }
  }
}
