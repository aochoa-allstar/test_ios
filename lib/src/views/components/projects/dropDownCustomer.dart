// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onax_app/src/controllers/addNewTicketController.dart';
import 'package:onax_app/src/controllers/projectsController.dart';

class DropDownCustomerProject extends StatelessWidget {
  final ProjectController controller;
  final String hint;
  final String validator;
  DropDownCustomerProject({
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
      width: w * 0.7,
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
            label: const Text('Customer'),
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
          items: controller.customerList
              .map((item) => DropdownMenuItem<String>(
                    value: '${item.id}-${item.name}',
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
            if (value == '') {
              return validator;
            }
            return null;
          },
          onChanged: (value) async {
            //Do something when changing the item if you want.
            late List<String> valSend = value.toString().split('-');
            print(valSend);
            await controller.selectCustomer(valSend);
          },
          onSaved: (value) async {
            late List<String> valSend = value.toString().split('-');
            await controller.selectCustomer(valSend);
          },
        ),
      ),
    );
  }
}
