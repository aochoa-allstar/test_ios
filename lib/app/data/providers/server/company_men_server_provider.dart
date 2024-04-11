import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class CompanyMenServerProvider extends BaseServerProvider {
  Future<Response> getAllCompanyMen() async {
    return await get(ApiRoutes.COMPANY_MEN);
  }

  // TODO: Check v2 compliance
  Future<Response> getCompanyMenByCustomer(int companyId) async {
    return await get('${ApiRoutes.GET_CUSTOMER_COMPANY_MEN}/$companyId');
    // return await get('${ApiRoutes.COMPANY_MEN}/$companyId');
  }
}
