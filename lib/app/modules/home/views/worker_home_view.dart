import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/home/controllers/home_controller.dart';
import 'package:onax_app/app/modules/shift/widgets/shift_status_indicator.dart';
import 'package:onax_app/app/modules/ticket/widgets/current_ticket_card.dart';
import 'package:onax_app/app/modules/ticket/widgets/ticket_history.dart';

class WorkerHomeView extends GetView<HomeController> {
  WorkerHomeView({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.fetchInfo(),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ShiftStatusIndicator(),
            SizedBox(height: 24),
            Obx(() => controller.shift.value != null
                ? CurrentTicketCard()
                : const SizedBox.shrink()),
            SizedBox(height: 24),
            TicketHistory(listLength: 5),
          ],
        ),
      ),
    );
  }
}
