import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/destination_model.dart';
import 'package:onax_app/app/data/providers/local/destinations_local_provider.dart';
import 'package:onax_app/app/data/providers/server/destinations_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class DestinationsRepository extends GetxController {
  DestinationsRepository(
      {required this.serverProvider, required this.localProvider});

  final DestinationsServerProvider serverProvider;
  final DestinationsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Destination.fromJson(data);
    if (data is List) return data.map((item) => Destination.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> createDestination() async {
    final body = {
      'id': null
    };

    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createDestination()
            : await serverProvider.createDestination(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getAllDestinations() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getAllDestinations()
            : await serverProvider.getAllDestinations();

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getDestination() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getDestination()
            : await serverProvider.getDestination(1);

    return decodeResponse(httpResponse);
  }
}
