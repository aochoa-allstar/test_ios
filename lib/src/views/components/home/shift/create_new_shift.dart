// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/createShiftController.dart';
import 'dart:io' show Platform;
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/pages_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'dropdownCustome.dart';

class CreateNewShiftFormScrenn extends StatelessWidget {
  CreateNewShiftFormScrenn({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final CreateShiftController _createShiftController =
        CreateShiftController();
    return WillPopScope(
      onWillPop: () async {
        Get.off(
          () => PagesScreen(),
          arguments: {'page': 0},
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 250),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(
                () => PagesScreen(),
                arguments: {'page': 0},
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 250),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            'home_shift_start_shift'.tr,
            style: ThemeWhite().titleBar(Colors.white),
          ),
        ),
        body: GetBuilder<CreateShiftController>(
          init: _createShiftController,
          builder: (_) => Container(
            width: w,
            height: h,
            child: _.loadOldTickets == false
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _form(_),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  _form(CreateShiftController _) {
    return Container(
      width: w,
      height: h * 1.1,
      //color: Colors.yellow,
      margin: EdgeInsets.symmetric(horizontal: w * 0.1),
      child: Column(
        children: [
          SizedBox(
            height: h * 0.04,
          ),
          _selecRoll(_),
          SizedBox(
            height: h * 0.04,
          ),
          _selectHeleper(_),
          SizedBox(
            height: h * 0.04,
          ),
          _selectHeleper2(_),
          SizedBox(
            height: h * 0.04,
          ),
          _selectHeleper3(_),
          SizedBox(
            height: h * 0.04,
          ),
          _startShift(_),
          Spacer(),
        ],
      ),
    );
  }

  _selecRoll(CreateShiftController controller) {
    late Widget widget;
    late Key rollKey = const Key('rollKey');
    if (Platform.isAndroid) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: rollKey,
            controller: controller,
            listItems: controller.listWorkerType,
            hint: 'start_shift_role_hint'.tr,
            validator: 'start_shift_role_validator'.tr,
            typeSelect: 0,
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: rollKey,
            controller: controller,
            listItems: controller.listWorkerType,
            hint: 'start_shift_role_hint'.tr,
            validator: 'start_shift_role_validator'.tr,
            typeSelect: 0,
          ),
        ),
      );
    }
    // return AccountPrefs.type == 'operator' || AccountPrefs.type == 'driver'
    //     ?
    //     : Container();
    return widget;
  }

  _selectEquipmentOrVehicle(CreateShiftController controller) {
    late Widget widget;
    late Key equipmentKye = const Key('equipment');
    if (Platform.isAndroid) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: equipmentKye,
            controller: controller,
            listItems: controller.listEquipment,
            hint: 'start_shift_equipment_hint'.tr,
            validator: 'start_shift_equipment_validator'.tr,
            typeSelect: 1,
          ),
        ),
      );
    }

    if (Platform.isIOS) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: equipmentKye,
            controller: controller,
            listItems: controller.listEquipment,
            hint: 'start_shift_equipment_hint'.tr,
            validator: 'start_shift_equipment_validator'.tr,
            typeSelect: 1,
          ),
        ),
      );
    }
    // return AccountPrefs.type == 'operator' || AccountPrefs.type == 'driver'
    //     ? widget
    //     : Container();
    return widget;
  }

  _selectHeleper(CreateShiftController controller) {
    late Widget widget;
    late Key helper1Kye = const Key('helper1');
    if (Platform.isAndroid) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper1Kye,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 2,
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper1Kye,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 2,
          ),
        ),
      );
    }
    return AccountPrefs.type != 'helper' ? widget : Container();
  }

  _selectHeleper2(CreateShiftController controller) {
    late Widget widget;
    late Key helper2 = const Key('helper2');
    if (Platform.isAndroid) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper2,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 3,
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper2,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 3,
          ),
        ),
      );
    }
    return AccountPrefs.type != 'helper' ? widget : Container();
  }

  _selectHeleper3(CreateShiftController controller) {
    late Widget widget;
    late Key helper3 = const Key('helper3');
    if (Platform.isAndroid) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper3,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 4,
          ),
        ),
      );
    }
    if (Platform.isIOS) {
      widget = Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: CustomeDropDown(
            typeKey: helper3,
            controller: controller,
            listItems: controller.listWorkersHelpers,
            hint: 'start_shift_helper_hint'.tr,
            validator: 'start_shift_helper_validator'.tr,
            typeSelect: 4,
          ),
        ),
      );
    }
    return AccountPrefs.type != 'helper' ? widget : Container();
  }

  _startShift(CreateShiftController controller) {
    return RoundedLoadingButton(
      height: h * 0.07,
      width: w * 0.7,
      color: Colors.blue,
      controller: controller.btnController1,
      onPressed: () async {
        AccountPrefs.statusConnection == true
            ? await controller.storeStartShift()
            : await controller.storeStartShiftNotWIFI();
      },
      borderRadius: 15,
      child: Text(
        'home_shift_start_shift'.tr,
        style: ThemeWhite().labelBtnActions(Colors.white),
      ),
    );
  }
}
