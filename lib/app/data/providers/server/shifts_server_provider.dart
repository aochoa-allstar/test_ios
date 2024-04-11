import 'package:get/get.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class ShiftsServerProvider extends BaseServerProvider {
  Future<Response> createShift(Shift body) async {
    return await post(
      ApiRoutes.SHIFT,
      body.toJson(),
      headers: {'notify-on-success': 'true'},
    );
  }

  Future<Response> getCurrentShift() async {
    return await get(ApiRoutes.CURRENT_SHIFT);
  }

  Future<Response> finishShift() async {
    return await delete(ApiRoutes.SHIFT);
  }
}
