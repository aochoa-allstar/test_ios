import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onax_app/app/modules/ticket/controllers/update_ticket_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Step stepTwo(int stepIndex, formKey) {
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
      child: Obx(
        () => FormBuilder(
          key: formKey,
          child: controller.ticket.value?.departTimestamp == null
              ? RoundedLoadingButton(
                  borderRadius: 16,
                  color: Colors.black,
                  controller: controller.departButton,
                  onPressed: () => controller.depart(),
                  child: Text(
                    'tickets_steps_step${stepIndex + 1}'.tr,
                    style: TextStyle(color: Colors.white),
                  ))
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "tickets_fields_departTime".tr +
                        ": " +
                        DateFormat('MM/dd/yyyy HH:mm').format(
                          DateTime.parse(
                              controller.ticket.value!.departTimestamp!),
                        ),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
      ),
    ),
  );
}
