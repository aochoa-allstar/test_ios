import 'package:get/get.dart';

import '../models/origin_model.dart';

class OriginProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Origin.fromJson(map);
      if (map is List) return map.map((item) => Origin.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Origin?> getOrigin(int id) async {
    final response = await get('origin/$id');
    return response.body;
  }

  Future<Response<Origin>> postOrigin(Origin origin) async =>
      await post('origin', origin);
  Future<Response> deleteOrigin(int id) async => await delete('origin/$id');
}
