import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class EquipmentsServerProvider extends BaseServerProvider {
  Future<Response> getAllEquipments() async {
    return await get(ApiRoutes.EQUIPMENTS);
  }

  Future<Response> getTrucks() async {
    return await get(ApiRoutes.GET_TRUCKS);
  }

  Future<Response> getTrailers() async {
    return await get(ApiRoutes.GET_TRUCKS);
  }
}
