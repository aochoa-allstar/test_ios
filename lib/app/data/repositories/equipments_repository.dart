import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/equipment_model.dart';
import 'package:onax_app/app/data/providers/local/equipments_local_provider.dart';
import 'package:onax_app/app/data/providers/server/equipments_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class EquipmentsRepository extends GetxController {
  EquipmentsRepository(
      {required this.serverProvider, required this.localProvider});

  final EquipmentsServerProvider serverProvider;
  final EquipmentsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Equipment.fromJson(data);
    if (data is List)
      return data.map((item) => Equipment.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getAllEquipments() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getAllEquipments();
    } else {
      httpResponse = await serverProvider.getAllEquipments();
      ApiResponse apiResponse = httpResponse.body;
      if (apiResponse.success != null && apiResponse.success!) {
        localProvider.populateEquipmentsTable(apiResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getTrucks() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getTrucks();
    } else {
      httpResponse = await serverProvider.getTrucks();
      ApiResponse apiResponse = httpResponse.body;
      if (apiResponse.success != null && apiResponse.success!) {
        localProvider.populateTrucksTable(apiResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getTrailers() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getTrailers()
            : await serverProvider.getTrailers();

    return decodeResponse(httpResponse);
  }
}
