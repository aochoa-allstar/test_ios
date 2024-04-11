import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/ticket/widgets/ticket_list_item.dart';

import '../controllers/list_tickets_controller.dart';

class ListTicketsView extends GetView<ListTicketsController> {
  ListTicketsView({Key? key}) : super(key: key);
  final ListTicketsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tickets_title'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.getTickets(),
          child: Obx(
            () => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.tickets.value.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return TicketListItem(
                    ticket: controller.tickets.value[index],
                    index: index,
                    length: controller.tickets.value.length);
              },
            ),
          ),
        ),
      ),
    );
  }
}
