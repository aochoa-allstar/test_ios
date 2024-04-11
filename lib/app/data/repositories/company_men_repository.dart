import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/company_man_model.dart';
import 'package:onax_app/app/data/providers/local/company_men_local_provider.dart';
import 'package:onax_app/app/data/providers/server/company_men_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class CompanyMenRepository extends GetxController {
  CompanyMenRepository(
      {required this.serverProvider, required this.localProvider});

  final CompanyMenServerProvider serverProvider;
  final CompanyMenLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return CompanyMan.fromJson(data);
    if (data is List)
      return data.map((item) => CompanyMan.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getAllCompanyMen() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getAllCompanyMen();
    } else {
      httpResponse = await serverProvider.getAllCompanyMen();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateAllCompanyMen(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getCompanyMenByCustomer() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getCompanyMenByCustomer()
            : await serverProvider.getCompanyMenByCustomer(1);

    return decodeResponse(httpResponse);
  }
}
