import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class AuthServerProvider extends BaseServerProvider {
  Future<Response> logIn(body) async {
    return await post(ApiRoutes.LOG_IN, body);
  }

  Future<Response> logOut() async {
    return await post(ApiRoutes.LOG_OUT, null);
  }
  
  Future<Response> recoverPassword(body) async {
    return await post(ApiRoutes.RECOVER_PASSWORD, body);
  }
}
