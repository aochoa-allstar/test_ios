import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class WorkersServerProvider extends BaseServerProvider {
  Future<Response> getHelpers() async {
    return await get(ApiRoutes.GET_HELPER_WORKERS);
  }

  Future<Response> getSupervisors() async {
    return await get(ApiRoutes.GET_SUPERVISOR_WORKERS);
  }

  Future<Response> getWorkerTypes() async {
    return await get(ApiRoutes.GET_WORKER_TYPES);
  }

  Future<Response> getWorkerById(int id) async {
    return await get(ApiRoutes.CURRENT_WORKER + "/$id");
  }
}
