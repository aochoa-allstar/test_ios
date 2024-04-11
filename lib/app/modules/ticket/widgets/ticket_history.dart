import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/home/controllers/home_controller.dart';
import 'package:onax_app/app/modules/ticket/widgets/ticket_list_item.dart';
import 'package:onax_app/app/routes/app_pages.dart';

// ignore: must_be_immutable
class TicketHistory extends StatelessWidget {
  TicketHistory({
    super.key,
    this.listLength,
  });

  final HomeController controller = Get.find();
  int? listLength;

  @override
  Widget build(BuildContext context) {
    if (listLength == null) {
      return unlimitedList();
    } else {
      return limitedList();
    }
  }

  Obx unlimitedList() {
    return Obx(
      () => Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.tickets.value.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.grey.shade200),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            for (var ticket in controller.tickets.value)
                              TicketListItem(
                                  ticket: ticket,
                                  index:
                                      controller.tickets.value.indexOf(ticket),
                                  length: controller.tickets.value.length),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Colors.grey.shade900,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'tickets_noPastTickets'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Obx limitedList() {
    return Obx(
      () => Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home_ticket_history_title'.tr,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  if (controller.tickets.value.length > listLength!)
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: (() => Get.toNamed(Routes.LIST_TICKETS)),
                      child: Text(
                        'home_ticket_history_view_all'.tr,
                        style: TextStyle(color: Colors.indigo),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(height: 8),
            controller.tickets.value.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Colors.grey.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children:
                              controller.tickets.value.asMap().entries.map((e) {
                            var index = e.key;
                            var ticket = e.value;
                            if (index >= listLength!) return Container();
                            //if the item is not the last one, add a divider
                            if (index != listLength! - 1 &&
                                index != controller.tickets.value.length - 1) {
                              return Column(
                                children: [
                                  TicketListItem(
                                    ticket: ticket,
                                    index: index,
                                    length: controller.tickets.value.length,
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return TicketListItem(
                              ticket: ticket,
                              index: index,
                              length: controller.tickets.value.length,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Colors.grey.shade900,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'tickets_noPastTickets'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
