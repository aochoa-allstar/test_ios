import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/driver_location_model.dart';
// import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/providers/local/driver_locations_local_provider.dart';
import 'package:onax_app/app/data/providers/server/driver_locations_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
// import 'package:onax_app/core/services/user_location_service.dart';

class DriverLocationsRepository extends GetxController {
  DriverLocationsRepository(
      {required this.serverProvider, required this.localProvider});

  final DriverLocationsServerProvider serverProvider;
  final DriverLocationsLocalProvider localProvider;

  SQLiteService dataBaseSQLite = Get.find();
  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  PreferencesService preferencesService = Get.find();
  // UserLocationService userLocationService = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return DriverLocationModel.fromJson(data);
    if (data is List)
      return data.map((item) => DriverLocationModel.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> createDriverLocation(
    int workerId,
    String longitude,
    String latitude,
    String initDate,
    String endDate,
    double speed,
  ) async {
    final body = {
      'worker_id': workerId,
      'longitude': longitude,
      'latitude': latitude,
      'init_date': initDate,
      'end_date': endDate,
      'speed': speed,
    };
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createDriverLocation(body)
            : await serverProvider.createDriverLocation(body);
    return httpResponse.body;
  }
}
