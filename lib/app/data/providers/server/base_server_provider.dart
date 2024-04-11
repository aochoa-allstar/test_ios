import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:onax_app/app/data/enums/preferences_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class BaseServerProvider extends GetConnect {
  PreferencesService preferences = Get.find();

  injectIdToUrl(String route) => '$route/${preferences.getSession().userId}';
  // injectIdToUrl(String route, int? entityId) => entityId == null ? '$route/${preferences.getSession().userId}' : '$route/${entityId}';

  @override
  void onInit() {
    httpClient.baseUrl = ApiRoutes.BASE;
    httpClient.defaultContentType = 'application/json';
    httpClient.defaultDecoder = (map) {
      if (map.runtimeType == String) {
        // If the API returns an HTML file/string it'll process it here
        return ApiResponse(data: map);
      } else {
        // Else, return the known {success: bool, data: {}, message: ''} structure
        return ApiResponse.fromJson(map);
      }
    };

    // Inject Authorization header
    httpClient.addRequestModifier((Request request) {
      request.headers.addIf(
        preferences.getPreference(Preferences.sessionToken) != null,
        'Authorization',
        'Bearer ${preferences.getPreference(Preferences.sessionToken)}',
      );
      return request;
    });

    // Assert notifier after receiving a response from the corresponding repository
    httpClient.addResponseModifier((Request request, Response response) async {
      responseNotifier(request, response);
      return response;
    });

    super.onInit();
  }
}

responseNotifier(Request? request, Response response) {
  NetworkService networkService = Get.find();

  ApiResponse apiResponse = response.body;

  String fallbackSuccessMessage = '';

  if (request?.method == 'POST') fallbackSuccessMessage = 'snackbar_success_create';
  if (request?.method == 'PUT') fallbackSuccessMessage = 'snackbar_success_update';
  if (request?.method == 'DELETE') fallbackSuccessMessage = 'snackbar_success_delete';

  switch (response.statusCode) {
    case 200:
    case 201:
    case 202:
      // Successful Request
      if (request != null && request.headers.containsKey('notify-on-success'))
        // Check if request includes special header to notify on success
        Get.snackbar(
          'snackbar_success_title'.tr,
          apiResponse.message == null
              ? fallbackSuccessMessage.tr
              : apiResponse.message!,
          backgroundColor: Colors.green.withAlpha(150),
          isDismissible: true,
          margin: EdgeInsets.all(16),
        );  
      break;

    case 408:
      // Request Timeout
      networkService.getNetworkSpeed(networkService.connectionType.value!);
      break;

    default:
      String errorTitle = request == null
          ? 'snackbar_error_title_local'
          : 'snackbar_error_title_server';

      Get.snackbar(
        errorTitle.tr,
        apiResponse.message == null
            ? 'snackbar_error_fallback'.tr
            : apiResponse.message!,
        colorText: Colors.white,
        backgroundColor: Colors.red.withAlpha(150),
        isDismissible: true,
        margin: EdgeInsets.all(16),
      );
  }
}
