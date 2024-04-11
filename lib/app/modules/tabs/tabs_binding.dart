import 'package:get/get.dart';
import 'package:onax_app/app/modules/tabs/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(() => TabsController());
  }
}
