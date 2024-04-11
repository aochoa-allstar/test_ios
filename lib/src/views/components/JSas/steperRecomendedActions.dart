import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class RecomendedActionsSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  RecomendedActionsSteper({Key? key, required this.controller})
      : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //jobDescription
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.22,
            width: w * 0.7,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                maxLines: null,
                controller: controller.recomendedActions, //change variable
                style: ThemeWhite().labelHomeTitles(Colors.black),
                onChanged: (value) {
                  if (controller.recomendedActions.text.isEmpty) {
                    //change varialble
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2058),
                ],
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: StyleInput().textAreaStyle(
                    'new_jsas_recomended'.tr, Colors.white),
              ),
            ),
          ),

          //
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }
}
