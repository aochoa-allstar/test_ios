import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class DestinationsServerProvider extends BaseServerProvider {
  Future<Response> createDestination(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.DESTINATIONS,
      body,
    );
  }

  Future<Response> getAllDestinations() async {
    return await get(ApiRoutes.DESTINATIONS);
  }

  Future<Response> getDestination(int id) async {
    return await get('${ApiRoutes.DESTINATIONS}/${id}');
  }
}
