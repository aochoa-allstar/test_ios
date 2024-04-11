import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class DriverLocationsServerProvider extends BaseServerProvider {
  Future<Response> createDriverLocation(Map<String, dynamic> body) async {
    return await post(ApiRoutes.DRIVER_LOCATIONS, body);
  }
}
