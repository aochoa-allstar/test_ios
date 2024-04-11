import 'package:get/get.dart';
import 'package:location/location.dart';

class UserLocationService extends GetxController implements GetxService {
  Future<UserLocationService> init() async => this;

  Location _location = new Location();

  //Does not request permission on init because it will request permission on the service registration
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> requestLocationPermission() async {
    final locationEnabled = await isLocationEnabled();
    final permissionGranted = await isPermissionGranted();

    if (!permissionGranted || !locationEnabled) {
      await _location.requestPermission();
    }
  }

  Future<bool> isLocationEnabled() async {
    bool _serviceEnabled;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return await _location.serviceEnabled();
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus _permissionGranted;

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  //If the user has not granted permission, it will request permission until it is granted or denied
  Future<LocationData> getLocation() async {
    LocationData _locationData;
    final permissionGranted = await isPermissionGranted();

    if (permissionGranted) {
      _locationData = await _location.getLocation();
      return _locationData;
    } else {
      await requestLocationPermission();
      return getLocation();
    }
  }
}
