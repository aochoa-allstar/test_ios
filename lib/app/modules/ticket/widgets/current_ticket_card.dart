import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/home/controllers/home_controller.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class CurrentTicketCard extends StatelessWidget {
  final HomeController controller = Get.find();

  final List<String> _titles = ["Departed", "Arrived", "Finished"];
  final Color _activeColor = Colors.green.shade300;
  final Color _inactiveColor = Colors.grey.shade700;
  final double separatorThickness = 3;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        clipBehavior: Clip.hardEdge,
        child: controller.activeTicket.value != null
            ? GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.UPDATE_TICKET,
                  arguments: controller.activeTicket.value!.id,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.grey.shade900),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                child: Text(
                                  controller
                                          .activeTicket.value?.project?.name ??
                                      'tickets_noProjectTitle'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              controller.activeTicket.value?.dateFormatted !=
                                      null
                                  ? Text(
                                      controller
                                          .activeTicket.value!.dateFormatted!,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: controller.activeTicket.value?.prefix != null
                                ? Text(
                                    "#" +
                                        controller.activeTicket.value!.prefix!,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      decoration: BoxDecoration(color: Colors.grey.shade900),
                      child: Column(
                        children: [
                          Row(children: _iconsList()),
                          SizedBox(height: 8),
                          Row(
                            children: _titlesList(),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(color: Colors.grey.shade900),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'home_project_noActiveProject'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    !(controller.loading.value)
                        ? FilledButton(
                            onPressed: () => Get.toNamed(Routes.CREATE_TICKET),
                            child: Text(
                              'home_project_createProject'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.green.shade300),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 48,
                          )
                  ],
                ),
              ),
      ),
    );
  }

  List<Widget> _iconsList() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, icon) {
      var lineColor =
          controller.activeTicketStep > i + 1 ? _activeColor : _inactiveColor;
      var iconColor =
          (controller.activeTicketStep > i) ? _activeColor : _inactiveColor;

      list.add(
        Container(
          width: 16,
          height: 16,
          padding: EdgeInsets.all(0),
          child: Icon(
            Icons.circle,
            color: iconColor,
            size: 16,
          ),
        ),
      );

      //line between icons
      if (i != _titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: separatorThickness,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titlesList() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    });
    return list;
  }
}
