import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/ticket/controllers/update_ticket_controller.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Step stepThree(int stepIndex, formKey) {
  UpdateTicketController controller = Get.find();
  return Step(
    title: Text(
      'tickets_steps_step${stepIndex + 1}'.tr,
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.openPhotoMenu(),
              child: Obx(
                () => controller.arrivedPhotoURL.value != null
                    ? changeNetworkImageWidget(controller)
                    : changeLocalImageWidget(controller),
              ),
            ),
            _jsaCheckbox(controller),
            if (controller.jsaCreated.value == false)
              RoundedLoadingButton(
                animateOnTap: false,
                borderRadius: 16,
                color: Colors.black,
                controller: controller.arriveButton,
                onPressed: () => Get.toNamed(Routes.CREATE_JSA, arguments: {
                  'ticket_id': controller.ticket.value!.id,
                  'customer_id': controller.ticket.value!.customerId,
                  'project_id': controller.ticket.value!.projectId,
                  'helper1_id': controller.ticket.value!.helperId,
                  'helper2_id': controller.ticket.value!.helper2Id,
                  'helper3_id': controller.ticket.value!.helper3Id,
                  "workers": controller.ticket.value!.aditionalWorkers,
                })?.then((value) => controller.handleGetNewJSA(value)),
                child: Text(
                  'jsas_create_submit'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (controller.jsaCreated.value == true)
              RoundedLoadingButton(
                borderRadius: 16,
                color: Colors.black,
                controller: controller.arriveButton,
                onPressed: () => controller.depart(),
                child: Text(
                  'tickets_steps_step${stepIndex + 1}'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
    ),
  );
}

//This widget is for the taken photo
Container changeLocalImageWidget(UpdateTicketController controller) {
  return Container(
    height: 256,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    width: double.maxFinite,
    child: controller.arrivedPhotoPath.value != null
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Image.file(
                fit: BoxFit.cover,
                File(controller.arrivedPhotoPath.value ?? "")),
          )
        : Icon(Icons.camera_alt_outlined),
  );
}

//This widget is for the URL or database photo
Container changeNetworkImageWidget(UpdateTicketController controller) {
  return Container(
    height: 256,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    width: double.maxFinite,
    child: controller.arrivedPhotoURL.value != null
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //We check if the URL is a network URL or a base64 string from the database
            child: controller.arrivedPhotoURL.value!.contains("http")
                ? Image.network(
                    fit: BoxFit.cover,
                    controller.arrivedPhotoURL.value ?? "",
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.network_locked_outlined),
                  )
                : Image.memory(
                    base64Decode(controller.arrivedPhotoURL.value!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  ),
          )
        : Icon(Icons.camera_alt_outlined),
  );
}

Widget _jsaCheckbox(UpdateTicketController controller) {
  return CheckboxListTile(
    value: controller.jsaCreated.value,
    onChanged: (value) => controller.jsaCreated.value = value!,
    title: Text('tickets_fields_jsa'.tr),
    enabled: false,
  );
}
