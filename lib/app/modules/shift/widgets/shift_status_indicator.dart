import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/home/controllers/home_controller.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class ShiftStatusIndicator extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => controller.shift.value == null
          ? Get.toNamed(Routes.CREATE_SHIFT)
          : controller.finishShift()),
      child: Container(
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.currentWorker.value?.name ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    //TODO add company id with the new endpoint
                    // Text(controller.currentCustomer.value?.name ?? ''),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Obx(() => Row(
                      children: [
                        Text(controller.shift.value == null
                            ? 'home_shift_state_inactive'.tr
                            : 'home_shift_state_active'.tr),
                        SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: controller.shift.value == null
                                ? Colors.red.shade400
                                : Colors.green.shade400,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
