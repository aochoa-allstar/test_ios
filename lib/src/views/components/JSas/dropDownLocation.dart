// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:onax_app/src/controllers/inspectionsController.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';

class CustomeDropDownLocationJSA extends StatelessWidget {
  final JsasSteperFormController controller;
  final List<dynamic> listItems;
  final String hint;
  final String validator;
  final int typeSelect;
  CustomeDropDownLocationJSA(
      {Key? key,
      required this.controller,
      required this.listItems,
      required this.hint,
      required this.validator,
      this.typeSelect = 0})
      : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return DropdownButtonFormField2(
      dropdownMaxHeight: h * 0.2,
      //value: controller.locationSelected,
      //value: typeSelect == 1 ? controller.helperID : controller.helperID2,
      decoration: InputDecoration(
        label: const Text('Location'),
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Center(
        child: Text(
          hint,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: listItems
          .map((item) => DropdownMenuItem<String>(
                value: item.name,
                child: Center(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ))
          .toList(),
      // validator: (value) {
      //   if (value == 0) {
      //     return validator;
      //   }
      // },
      onChanged: (value) {
        // controller.selectEquimpent(value);
        //Do something when changing the item if you want.
        //controller.selectHelper(value);
        controller.selectedLocation(value!);
      },
      onSaved: (value) {
        // controller.selectEquimpent(value);
        //controller.selectHelper(value);
      },
    );
  }
}
