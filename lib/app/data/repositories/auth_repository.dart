import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/languages_enum.dart';
import 'package:onax_app/app/data/enums/user_types_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/providers/local/auth_local_provider.dart';
import 'package:onax_app/app/data/providers/server/auth_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class AuthRepository extends GetxController {
  AuthRepository({required this.serverProvider, required this.localProvider});

  final AuthServerProvider serverProvider;
  final AuthLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  Future<ApiResponse> logIn(String email, String password) async {
    Response httpResponse;
    ApiResponse apiResponse;
    String databaseTable = 'sessions';
    Map<String, String> body = {
      'email': email,
      'password': password,
      'deviceToken': 'sample_device_token'
    };

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.logIn(body, databaseTable);
      apiResponse = httpResponse.body;
    } else {
      httpResponse = await serverProvider.logIn(body);
      apiResponse = httpResponse.body;
    }

    if (apiResponse.success == true) {
      preferences.setSession(
        Session(
          userId: apiResponse.data['user']['id'],
          userType: UserTypes.worker,
          sessionToken: apiResponse.data['token'],
          language: apiResponse.data['user']['language'] == 'english'
              ? Languages.english
              : Languages.spanish,
        ),
      );
    }

    return apiResponse;
  }

  Future<ApiResponse> recoverPassword() async {
    return ApiResponse(success: false, message: 'Unimplemented');
  }

  Future<ApiResponse> logOut() async {
    Response httpResponse;
    ApiResponse apiResponse;
    String databaseTable = 'sessions';

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.logOut(databaseTable);
      apiResponse = httpResponse.body;
    } else {
      httpResponse = await serverProvider.logOut();
      apiResponse = httpResponse.body;
    }

    if (apiResponse.success == true) preferences.removeSession();

    return apiResponse;
  }
}
