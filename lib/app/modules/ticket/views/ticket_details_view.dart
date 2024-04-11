import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/ticket/controllers/ticket_details_controller.dart';
import 'package:hand_signature/signature.dart';

class TicketDetailsView extends GetView<TicketDetailsController> {
  TicketDetailsView({Key? key}) : super(key: key);

  final TicketDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tickets_details_title'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => controller.ticketLoaded.value
              ? controller.ticketSignature.value == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: WebViewWidget(
                            controller: controller.webViewController.value!,
                          ),
                        ),
                        //Workers are not allowed to sign tickets
                        // Container(
                        //   height: 150,
                        //   width: double.infinity,
                        //   margin: EdgeInsets.symmetric(horizontal: 12),
                        //   decoration: BoxDecoration(
                        //       border: Border.fromBorderSide(
                        //           BorderSide(color: Colors.black, width: 1)),
                        //       borderRadius: BorderRadius.circular(12),
                        //       color: Colors.white),
                        //   child:
                        //       signaturePad(controller.signaturePadController),
                        // ),
                        // const SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () => controller
                        //           .signaturePadController.value
                        //           .clear(),
                        //       child: Text("tickets_details_clear".tr,
                        //           style: TextStyle(color: Colors.black)),
                        //     ),
                        //     RoundedLoadingButton(
                        //         color: Colors.black,
                        //         controller:
                        //             controller.saveSignatureButtonController,
                        //         onPressed: () => controller.hanldeSignTicket(),
                        //         child: Text(
                        //           "tickets_details_signTicket".tr,
                        //           style: TextStyle(color: Colors.white),
                        //         ))
                        //   ],
                        // ),
                        // const SizedBox(height: 16),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: WebViewWidget(
                            controller: controller.webViewController.value!,
                          ),
                        ),
                      ],
                    )
              : !controller.ticketFailed.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text("tickets_details_noDetails".tr),
                    ),
        ),
      ),
    );
  }

  Widget signaturePad(
    Rx<HandSignatureControl> signatureController,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: HandSignature(
        control: signatureController.value,
        color: Colors.black,
        type: SignatureDrawType.line,
        width: 2,
        onPointerUp: () => controller.handleOnPointerUp(signatureController),
      ),
    );
  }
}
