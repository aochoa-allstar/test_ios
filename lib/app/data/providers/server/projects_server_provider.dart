import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class ProjectsServerProvider extends BaseServerProvider {
  Future<Response> createProject(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.CREATE_PROJECT,
      body,
      headers: {'notify-on-success': 'true'},
    );
  }

  Future<Response> getAllProjects() async {
    return await get(ApiRoutes.PROJECTS);
  }

  Future<Response> getCustomerProjects(int projectId) async {
    return await get('${ApiRoutes.GET_CUSTOMER_PROJECTS}/$projectId');
  }
}
