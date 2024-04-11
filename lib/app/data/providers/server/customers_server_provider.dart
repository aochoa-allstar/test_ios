import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class CustomersServerProvider extends BaseServerProvider {
  Future<Response> getCustomers() async {
    return await get(ApiRoutes.CUSTOMERS);
  }
}
