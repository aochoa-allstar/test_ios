import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/providers/local/shifts_local_provider.dart';
import 'package:onax_app/app/data/providers/server/shifts_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class ShiftsRepository extends GetxController {
  ShiftsRepository({required this.serverProvider, required this.localProvider});

  final ShiftsServerProvider serverProvider;
  final ShiftsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Shift.fromJson(data);
    if (data is List)
      return data.map((item) => Shift.fromJson(item)).toList().firstOrNull;
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> createShift(
    int workerId,
    int workerTypeId,
    int? helperId,
    int? helper2Id,
    int? helper3Id,
    int? equipmentId,
  ) async {
    final body = Shift(
      workerId: workerId,
      workerTypeId: workerTypeId,
      helperId: helperId,
      helper2Id: helper2Id,
      helper3Id: helper3Id,
      equipmentId: equipmentId,
    );

    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createShift(body)
            : await serverProvider.createShift(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getCurrentShift() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getCurrentShift();
    } else {
      httpResponse = await serverProvider.getCurrentShift();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateTable(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> finishShift() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.finishShift()
            : await serverProvider.finishShift();

    return httpResponse.body;
  }
}
