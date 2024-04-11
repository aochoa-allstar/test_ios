import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/worker_model.dart' as Worker;
import 'package:onax_app/app/data/providers/local/workers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/workers_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class WorkersRepository extends GetxController {
  WorkersRepository(
      {required this.serverProvider, required this.localProvider});

  final WorkersServerProvider serverProvider;
  final WorkersLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Worker.UserWorker.fromJson(data);
    if (data is List)
      return data.map((item) => Worker.UserWorker.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getHelpers() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getHelpers();
    } else {
      httpResponse = await serverProvider.getHelpers();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateHelpers(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getSupervisors() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getSupervisors();
    } else {
      httpResponse = await serverProvider.getSupervisors();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateSupervisors(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getWorkerTypes() async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getWorkerTypes();
    } else {
      httpResponse = await serverProvider.getWorkerTypes();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateWorkerTypes(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getWorkerById(int id) async {
    Response httpResponse;

    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getWorkerById(id);
    } else {
      httpResponse = await serverProvider.getWorkerById(id);
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateCurrentWorker(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }
}
