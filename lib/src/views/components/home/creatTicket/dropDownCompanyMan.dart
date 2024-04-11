// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/addNewTicketController.dart';

class DropDownCompanyMan extends StatelessWidget {
  final AddNewTicketController controller;
  final String hint;
  final String validator;
  DropDownCompanyMan({
    Key? key,
    required this.controller,
    required this.hint,
    required this.validator,
  }) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.07,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: DropdownButtonFormField2(
          dropdownMaxHeight: h * 0.2,
          decoration: InputDecoration(
            label: Text('new_ticket_companyman_label'.tr),
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
              style: TextStyle(fontSize: 14),
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
          items: controller.companyManList
              .map((item) => DropdownMenuItem<int>(
                    value: item.id,
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
          validator: (value) {
            if (value == 0) {
              return validator;
            }
            return null;
          },
          onChanged: (value) {
            //Do something when changing the item if you want.
            controller.selectCompanyMan(value);
          },
          onSaved: (value) {
            controller.selectCompanyMan(value);
          },
        ),
      ),
    );
  }
}
