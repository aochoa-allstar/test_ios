import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/origin_model.dart';
import 'package:onax_app/app/data/providers/local/origins_local_provider.dart';
import 'package:onax_app/app/data/providers/server/origins_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class OriginsRepository extends GetxController {
  OriginsRepository({required this.serverProvider, required this.localProvider});

  final OriginsServerProvider serverProvider;
  final OriginsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Origin.fromJson(data);
    if (data is List)
      return data.map((item) => Origin.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getOrigins() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getOrigins()
            : await serverProvider.getOrigins();

    return decodeResponse(httpResponse);
  }
}