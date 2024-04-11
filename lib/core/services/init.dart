import 'package:get/get.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
import 'package:onax_app/core/services/user_location_service.dart';

Future<void> initializeCoreServices() async {
  await Get.putAsync(() => PreferencesService().init());
  await Get.putAsync(() => SQLiteService().init());
  await Get.putAsync(() => NetworkService().init());
  await Get.putAsync(() => UserLocationService().init());
}
