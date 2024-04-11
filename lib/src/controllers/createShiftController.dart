import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';

import 'package:onax_app/src/repositories/models/workersModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_equipment.dart';
import 'package:onax_app/src/services/sqlite/sqlite_shift.dart';
import 'package:onax_app/src/services/sqlite/sqlite_workers.dart';

import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

import 'package:onax_app/src/views/pages_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../repositories/models/worker_typeModel.dart';
import '../utils/urlApi/globalApi.dart';

import 'package:http/http.dart' as http;

class CreateShiftController extends GetxController {
  final GlobalApi api = GlobalApi();
  late int _equipmentID;
  late int _helperID, _helperID2, _helperID3;
  late List<EquipmentModel> _listEquipment;
  late List<WorkerModel> _listWorkersHelpers;
  late RoundedLoadingButtonController _btnController1;

  late bool _loadOldTickets;
  late int workerTypeID;
  //late bool dataLoad;

  ///get

  int get equipmentID => _equipmentID;
  int get helperID => _helperID;
  int get helperID2 => _helperID2;
  int get helperID3 => _helperID3;
  List<EquipmentModel> get listEquipment => _listEquipment;
  List<WorkerModel> get listWorkersHelpers => _listWorkersHelpers;
  late List<WokerTypeModel> listWorkerType;
  bool get loadOldTickets => _loadOldTickets;
  RoundedLoadingButtonController get btnController1 => _btnController1;
  late ConnectionManagerController connectionManagerController;
  // bool get dataLoad => _dataLoad;
  @override
  void onInit() async {
    _loadOldTickets = true;
    // print(AccountPrefs.currentShift);
    _helperID = 0;
    _helperID2 = 0;
    _helperID3 = 0;
    _equipmentID = 0;
    workerTypeID = AccountPrefs.workerTypeID;
    _listEquipment = [];
    listWorkerType = [];
    _listWorkersHelpers = [];

    //dataLoad = true;
    _btnController1 = RoundedLoadingButtonController();
    connectionManagerController = Get.put(ConnectionManagerController());
    super.onInit();
  }

  @override
  void onReady() async {
    if (AccountPrefs.statusConnection == true) {
      await getEquipments();
      await getWokerTypeID();
      if (AccountPrefs.type != 'helper') {
        await getHelpers();
      }
      await downloadDataToApp();
    } else {
      await getEquimentNOTWIFI();
      if (AccountPrefs.type != 'helper') {
        await getHelpersNotInternet();
      }
    }
    // dataLoad = false;
    _loadOldTickets = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<CreateShiftController>();
    super.onClose();
  }

  //change state  and value of equipmentID
  selectEquimpent(id) {
    _equipmentID = id;
    update();
  }

  selectWorkerType(id) {
    workerTypeID = id;
    AccountPrefs.workerTypeID = id;
    update();
  }

  selectHelper(id) {
    _helperID = id;
    // if (_helperID == _helperID2 || _helperID == _helperID3) {
    //   Get.snackbar('Warning',
    //       'Please select another helper, beacuse this helper was selected in another option.',
    //       colorText: Colors.black,
    //       backgroundColor: Colors.yellow,
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: const Duration(seconds: 4));

    // }
    update();
  }

  selectHelper2(id) {
    _helperID2 = id;
    // if (_helperID2 == _helperID || _helperID2 == _helperID3) {
    //   Get.snackbar('Warning',
    //       'Please select another helper, beacuse this helper was selected in another option.',
    //       colorText: Colors.black,
    //       backgroundColor: Colors.yellow,
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: const Duration(seconds: 4));

    // }
    update();
  }

  selectHelper3(id) {
    _helperID3 = id;
    if (_helperID3 == _helperID2 || _helperID3 == _helperID) {}
    update();
  }

  /*
  GET EQUIpMENT
   */

  getEquipments() async {
    try {
      print(AccountPrefs.type);
      //loading dialog
      //if (AccountPrefs.type == 'driver' || AccountPrefs.type == 'operator') {
      final String urlApi = '${api.api}/${api.equipments}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print(decodeResp);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          _listEquipment = (decodeResp['data'] as List)
              .map((e) => EquipmentModel.fromJson(e))
              .toList();
        } else {
          _listEquipment = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listEquipment = [];
      }
      update();
      //}
      return _listEquipment;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listEquipment = [];
    }
  }

  getEquimentNOTWIFI() async {
    try {
      final response = await EquipmentSQL().getEquipmentTrucksSQL();

      //    Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listEquiCome = response['data'] as List;
          _listEquipment = [];
          for (var element in listEquiCome) {
            _listEquipment.add(element);
          }
        } else {
          _listEquipment = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listEquipment = [];
      }
      update();
      // }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listEquipment = [];
    }
  }

  /*GET WORKERTYPEID */
  getWokerTypeID() async {
    try {
      print(AccountPrefs.type);
      //loading dialog
      //if (AccountPrefs.type == 'driver' || AccountPrefs.type == 'operator') {
      final String urlApi = '${api.api}/${api.getWorkerTypes}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print(decodeResp);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listWorkerType = (decodeResp['data'] as List)
              .map((e) => WokerTypeModel.fromJson(e))
              .toList();
        } else {
          listWorkerType = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listWorkerType = [];
      }
      update();
      //}
      return listWorkerType;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listWorkerType = [];
    }
  }

/*
 * GET the HELPERS
 */
  getHelpers() async {
    try {
      //loading dialog
      if (AccountPrefs.type != 'helper') {
        final String urlApi = '${api.api}/${api.getHelpers}'; //url/api/login

        final header = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AccountPrefs.token}',
        };

        final response = await http.get(Uri.parse(urlApi), headers: header);

        Map<String, dynamic> decodeResp = json.decode(response.body);
        print(decodeResp);
        if (response.statusCode == 200 && decodeResp['success'] == true) {
          if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
            _listWorkersHelpers = ((decodeResp['data'] ?? []) as List)
                .map((e) => WorkerModel.fromJson(e))
                .toList();
          } else {
            _listWorkersHelpers = [];
          }
        }
        if (response.statusCode == 200 && decodeResp['success'] == false) {
          Get.snackbar('Warning',
              'Please try it later, we can not connect with the app.',
              colorText: Colors.white,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM);
          _listWorkersHelpers = [];
        }
      } else {
        _listWorkersHelpers = [];
      }
      update();
      print(_listWorkersHelpers);
      return _listWorkersHelpers;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listWorkersHelpers = [];
      return _listWorkersHelpers;
    }
  }

  getHelpersNotInternet() async {
    try {
      final response = await WorkersSQL().getWorkersSQL();

      //    Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listEquiCome = response['data'] as List;
          _listWorkersHelpers = [];
          for (var element in listEquiCome) {
            _listWorkersHelpers.add(element);
          }
        } else {
          _listWorkersHelpers = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listWorkersHelpers = [];
      }
      update();
      // }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listWorkersHelpers = [];
    }
  }

/*onax
 *Start new Shift 
 */
  storeStartShift() async {
    try {
      final String urlApi = '${api.api}/${api.newShift}';
      print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'worker_id': AccountPrefs.idUser,
        'start_time': null,
        'end_time': null,
        'equipment_id': _equipmentID,
        'helper_id': _helperID,
        'helper2_id': _helperID2,
        'helper3_id': _helperID3,
        'active': 1,
        'temId': 'NA',
        'worker_type_id': workerTypeID,
      };
      // if ((AccountPrefs.type == 'pusher' &&
      //         (_helperID != _helperID2 &&
      //             _helperID2 != _helperID3 &&
      //             _helperID3 != _helperID)) ||
      //     AccountPrefs.type != 'pusher')
      if ((_helperID != _helperID2 || _helperID == 0 && _helperID2 == 0) ||
          (_helperID2 != _helperID3 || _helperID2 == 0 && _helperID3 == 0) ||
          (_helperID3 != _helperID || _helperID3 == 0 && _helperID == 0) ||
          (_helperID == 0 && _helperID2 == 0 && _helperID3 == 0)) {
        final response = await http.post(Uri.parse(urlApi),
            headers: header, body: json.encode(body));

        Map<String, dynamic> decodeResp = json.decode(response.body);
        print(decodeResp['data']['shiftID']);
        if (response.statusCode == 200 && decodeResp['success'] == true) {
          if (decodeResp['data'].containsKey('shiftID')) {
            AccountPrefs.currentShift = decodeResp['data']['shiftID'];
            //_statusShiftTicket = decodeResp['data']['shiftID'];
            // Get.off(
            //   () => PagesScreen(),
            //   arguments: {'page': 0},
            //   transition: Transition.rightToLeft,
            //   duration: const Duration(milliseconds: 250),
            // );
            Get.offNamed('/pages');
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we not found information.',
              colorText: Colors.black,
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM);
          _btnController1.reset();
        }
        update();
      } else {
        Get.snackbar(
          'utils_warning'.tr,
          'start_shift_helper_warning_message'.tr,
          colorText: Colors.black,
          backgroundColor: Colors.yellow,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        _btnController1.reset();
      }

      //Get close loading
      //Get back to home,
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _btnController1.reset();
    }
  }

  storeStartShiftNotWIFI() async {
    try {
      // final String urlApi = '${api.api}/${api.newShift}';
      // print(urlApi);
      // final header = {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer ${AccountPrefs.token}',
      // };
      final body = {
        'worker_id': AccountPrefs.idUser,
        // 'start_time': null,
        'end_time': null,
        'equipment_id': _equipmentID,
        'helper_id': _helperID,
        'helper2_id': _helperID2,
        'helper3_id': _helperID3,
        'active': 1,
        'temId': '',
        'worker_type_id': workerTypeID,
      };
      // //
      // &&
      //         (_helperID != _helperID2 &&
      //             _helperID2 != _helperID3 &&
      //             _helperID3 != _helperID))
      //AccountPrefs.type == 'pusher'  ||
      //    AccountPrefs.type != 'pusher'
      if ((_helperID != _helperID2 || _helperID == 0 && _helperID2 == 0) ||
          (_helperID2 != _helperID3 || _helperID2 == 0 && _helperID3 == 0) ||
          (_helperID3 != _helperID || _helperID3 == 0 && _helperID == 0) ||
          (_helperID == 0 && _helperID2 == 0 && _helperID3 == 0)) {
        final response = await ShiftSQL().insertShiftFromAppSQL(body);

        //  Map<String, dynamic> decodeResp = json.decode(response.body);
        //  print(decodeResp['data']['shiftID']);
        if (response['statusCode'] == 200 && response['success'] == true) {
          if (response['data'].containsKey('shiftID')) {
            AccountPrefs.currentShift = response['data']['shiftID'];
            update();
            //_statusShiftTicket = decodeResp['data']['shiftID'];
            Get.offNamed('/pages');
            // Get.off(
            //   () => PagesScreen(),
            //   arguments: {'page': 0},
            //   transition: Transition.rightToLeft,
            //   duration: const Duration(milliseconds: 250),
            // );
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we not found information.',
              colorText: Colors.black,
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM);
          _btnController1.reset();
        }
        //update();
      } else {
        Get.snackbar(
          'utils_warning'.tr,
          'start_shift_helper_warning_message'.tr,
          colorText: Colors.black,
          backgroundColor: Colors.yellow,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        _btnController1.reset();
      }

      //Get close loading
      //Get back to home,
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _btnController1.reset();
    }
  }

  downloadDataToApp() async {
    await WorkersSQL().trucateWorkers();
    await EquipmentSQL().trucateEquipment();

    List<WorkerModel> listWorkers = await getHelpers();
    if (listWorkers.isNotEmpty) {
      for (var element in listWorkers) {
        await WorkersSQL().insert(element);
      }
      if (kDebugMode) {
        print('All workers are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing workers to sqlite');
      }
    }
    //Equipment
    List<EquipmentModel> listEquipment = [];
    listEquipment = await getEquipments();
    if (listEquipment.isNotEmpty) {
      for (var element in listEquipment) {
        await EquipmentSQL().insert(element);
      }
      if (kDebugMode) {
        print('All Equipments are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  Equipments to sqlite');
      }
    }
  }
  //END CLASS
}
