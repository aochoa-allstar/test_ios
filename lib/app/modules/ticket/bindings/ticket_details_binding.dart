import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/tickets_local_provider.dart';
import 'package:onax_app/app/data/providers/server/tickets_server_provider.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';
import 'package:onax_app/app/modules/ticket/controllers/ticket_details_controller.dart';

class TicketDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketDetailsController>(
      () => TicketDetailsController(),
    );
    Get.put<TicketsRepository>(
      TicketsRepository(
        serverProvider: Get.put(TicketsServerProvider()),
        localProvider: Get.put(TicketsLocalProvider()),
      ),
    );
  }
}
