import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/providers/local/customers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/customers_server_provider.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class CustomersRepository extends GetxController {
  CustomersRepository(
      {required this.serverProvider, required this.localProvider});

  final CustomersServerProvider serverProvider;
  final CustomersLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  dynamic decoder(data) {
    if (data is Map<String, dynamic>) return Customer.fromJson(data);
    if (data is List)
      return data.map((item) => Customer.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    ApiResponse apiResponse = httpResponse.body;
    apiResponse.data = decoder(apiResponse.data);
    return apiResponse;
  }

  Future<ApiResponse> getCustomers() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getCustomers();
    } else {
      httpResponse = await serverProvider.getCustomers();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        populateCustomersTable(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  void populateCustomersTable(dynamic data) {
    dataBaseSQLite.deleteTable(DatabaseTables.customers);
    if (data is List) {
      data.forEach((e) {
        final int customerId = e['id'];
        final pivotData = e['pivot'];
        var customerInfo = e;
        customerInfo.remove('pivot');

        dataBaseSQLite.insertIntoTable(DatabaseTables.customers, customerInfo);
        dataBaseSQLite.insertIntoTable(DatabaseTables.customersPivot, {
          'company_id': pivotData['company_id'],
          'customer_id': customerId,
          'company_created_at': pivotData['created_at'],
          'company_updated_at': pivotData['updated_at'],
        });
      });
    }
    if (data is Map<String, dynamic>) {
      dataBaseSQLite.insertIntoTable(DatabaseTables.customers, data);
    }
  }
}
