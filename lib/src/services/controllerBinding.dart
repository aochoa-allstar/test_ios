import 'package:get/get.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
