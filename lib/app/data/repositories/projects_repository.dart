import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/providers/local/projects_local_provider.dart';
import 'package:onax_app/app/data/providers/server/projects_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
import 'package:onax_app/core/services/user_location_service.dart';

class ProjectsRepository extends GetxController {
  ProjectsRepository(
      {required this.serverProvider, required this.localProvider});

  final ProjectsServerProvider serverProvider;
  final ProjectsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  UserLocationService userLocationService = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Project.fromJson(data);
    if (data is List)
      return data.map((item) => Project.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> createProject(
    int customerId,
    String name,
    String coords,
    int companyManId,
  ) async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createProject()
            : await serverProvider.createProject({
                "customer_id": customerId,
                "name": name,
                "coords": coords,
                "company_man_id": companyManId,
              });

    return decodeResponse(httpResponse);
  }

  Future<UserCoordinates> getLocation() async {
    final location = await userLocationService.getLocation();
    return UserCoordinates(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  Future<ApiResponse> getAllProjects() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getAllProjects();
    } else {
      httpResponse = await serverProvider.getAllProjects();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        populateAllProjectsTable(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  void populateAllProjectsTable(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.projects);
    if (data is List) {
      data.forEach(
          (e) => dataBaseSQLite.insertIntoTable(DatabaseTables.projects, e));
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.projects, data);
    }
  }
}
