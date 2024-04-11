import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/inspection/controllers/list_inspections_controller.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class ListInspectionsView extends GetView<ListInspectionsController> {
  ListInspectionsView({Key? key}) : super(key: key);

  final ListInspectionsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => controller.fetchInspections(),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              CreateInspectionCard(),
            ],
          )),
    );
  }

  Widget CreateInspectionCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
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
        decoration: BoxDecoration(color: Colors.grey.shade900),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'inspections_newInspection'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            FilledButton(
              onPressed: () => Get.toNamed(Routes.CREATE_PRE_INSPECTION),
              child: Text(
                'inspections_preTrip'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                backgroundColor:
                    MaterialStatePropertyAll(Colors.green.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),
            ),
            FilledButton(
              onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
              child: Text(
                'inspections_postTrip'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                backgroundColor:
                    MaterialStatePropertyAll(Colors.green.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
