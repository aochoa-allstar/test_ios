import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/driver_locations_local_provider.dart';
import 'package:onax_app/app/data/providers/server/driver_locations_server_provider.dart';
import 'package:onax_app/app/data/repositories/driver_locations_repository.dart';
import 'package:onax_app/app/modules/driverLocations/controllers/create_driver_location_controller.dart';

class CreateDriverLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDriverLocationController>(
      () => CreateDriverLocationController(),
    );
    Get.put<DriverLocationsRepository>(
      DriverLocationsRepository(
        serverProvider: Get.put(DriverLocationsServerProvider()),
        localProvider: Get.put(DriverLocationsLocalProvider()),
      ),
    );
  }
}
