import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class JSAsServerProvider extends BaseServerProvider {
  Future<Response> createJSA(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.CREATE_JSA,
      body,
      headers: {'notify-on-success': 'true'},
    );
  }

  Future<Response> signJSA(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.SIGN_JSA,
      body,
      headers: {'notify-on-success': 'true'},
    );
  }

  Future<Response> getJSAsByUser() async {
    return await get(ApiRoutes.JSAS);
  }

  Future<Response> getPDF(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.CREATE_TICKET,
      body,
      headers: {'notify-on-success': 'true'},
    );
  }
}
