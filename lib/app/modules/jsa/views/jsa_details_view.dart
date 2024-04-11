import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/app/modules/jsa/controllers/jsa_details_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class JSADetailsView extends GetView<JSADetailsController> {
  JSADetailsView({Key? key}) : super(key: key);

  final JSADetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jsas_details_title'.tr),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.ticketLoaded.value
            ? SizedBox(
                child: Column(
                children: [
                  Expanded(
                    child: WebViewWidget(
                      controller: controller.webViewController.value!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: "jsas_details_name".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) => controller.name.value = value,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 1)),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: signaturePad(controller.signaturePadController),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () =>
                            controller.signaturePadController.value.clear(),
                        child: Text("tickets_details_clear".tr,
                            style: TextStyle(color: Colors.black)),
                      ),
                      RoundedLoadingButton(
                          color: Colors.black,
                          controller: controller.saveSignatureButtonController,
                          onPressed: () => controller.handleSignJSA(),
                          child: Text(
                            "jsas_details_signJsa".tr,
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ))
            : !controller.ticketFailed.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text("jsas_details_noDetails".tr),
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
