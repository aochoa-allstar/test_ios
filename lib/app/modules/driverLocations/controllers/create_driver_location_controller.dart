import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/repositories/driver_locations_repository.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
import 'package:onax_app/core/services/user_location_service.dart';

class CreateDriverLocationController extends GetxController {
  final DriverLocationsRepository driverLocationsRepository = Get.find();
  final UserLocationService userLocationService = Get.find();
  PreferencesService preferences = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  final userLocation = UserCoordinates(latitude: null, longitude: null).obs;
  late LocationData? lastLocation;
  late Timer locationTimer;
  final session = Rx<Session?>(null);

  CreateDriverLocationController() {
    lastLocation = null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> startLocationUpdates() async {
    await userLocationService.getLocation();
    session.value = preferences.getSession();

    userLocationService.getLocation().then((LocationData? currentLocation) {
      locationTimer = Timer.periodic(Duration(seconds: 30), (timer) async {
        //First we get the current shift from the local database
        final dataBaseResponse =
            await dataBaseSQLite.getTable(DatabaseTables.currentShift);
        final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;
        final currentShift = data.firstOrNull;

        //If there is no active shift we stop the timer
        if (currentShift?["worker_id"] == null) {
          timer.cancel();
          return;
        }
        if (currentLocation != null) {
          if (lastLocation != null) {
            double distance = Geolocator.distanceBetween(
              lastLocation!.latitude!,
              lastLocation!.longitude!,
              currentLocation.latitude!,
              currentLocation.longitude!,
            );

            if (distance > 10) {
              createDriverLocation(
                session.value!.userId,
                currentLocation.longitude.toString(),
                currentLocation.latitude.toString(),
                DateTime.now().toIso8601String(), // Fecha de inicio
                DateTime.now().toIso8601String(), // Fecha de fin
                currentLocation.speed, // Velocidad
              );
            }
          }

          lastLocation = currentLocation;
        }
      });
    });
  }

  Future<void> createDriverLocation(
    int workerId,
    String longitude,
    String latitude,
    String initDate,
    String endDate,
    double? speed,
  ) async {
    await driverLocationsRepository.createDriverLocation(
        workerId, longitude, latitude, initDate, endDate, speed!);
  }
}
