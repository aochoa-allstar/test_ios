import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/repositories/models/companyManModel.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/repositories/models/desty_origin_Model.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/projectModel.dart';
import 'package:http/http.dart' as http;
import 'package:onax_app/src/services/sqlite/sqlite_company_men.dart';
import 'package:onax_app/src/services/sqlite/sqlite_customer.dart';
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_equipment.dart';
import 'package:onax_app/src/services/sqlite/sqlite_origins.dart';
import 'package:onax_app/src/services/sqlite/sqlite_project.dart';
import 'package:onax_app/src/services/sqlite/sqlite_shift.dart';
import 'package:onax_app/src/services/sqlite/sqlite_tickets.dart';
import 'package:onax_app/src/views/pages_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../repositories/models/shiftModel.dart';
import '../utils/sharePrefs/accountPrefs.dart';
import '../utils/urlApi/globalApi.dart';

class AddNewTicketController extends GetxController {
  final GlobalApi api = GlobalApi();

  late bool _loadOldTickets;
  late dynamic _scrollController;
  late String _customerSelected;
  late int _projectID,
      _customerID,
      _originID,
      _destinationID,
      _truckID,
      _companyManID;
  late List<EquipmentModel> _truckList;
  late List<CompanyManModel> _companyManList;
  late List<DestinyOriginModel> _originList;
  late List<DestinyOriginModel> _destinationList;
  late List<CustomerModel> _customerList;
  late List<ProjectModel> _projectsList;
  late int _equipmentID, _helperID, _helperID3, _helperID2;
  late RoundedLoadingButtonController _btnController1;

  bool get loadOldTickets => _loadOldTickets;
  dynamic get scrollController => _scrollController;
  int get projectID => _projectID;
  int get customerID => _customerID;
  int get originID => _originID;
  int get destintionID => _destinationID;
  int get truckID => _truckID;
  int get companyManID => _companyManID;

  List<EquipmentModel> get truckList => _truckList;
  List<CompanyManModel> get companyManList => _companyManList;
  List<DestinyOriginModel> get originList => _originList;
  List<DestinyOriginModel> get destinationList => _destinationList;
  List<CustomerModel> get customerList => _customerList;
  List<ProjectModel> get projectList => _projectsList;
  RoundedLoadingButtonController get btnController1 => _btnController1;
  late ConnectionManagerController connectionManagerController;
  late bool _dataLoad;
  bool get dataLoad => _dataLoad;
  @override
  void onInit() {
    _equipmentID = 0;
    _helperID = 0;
    _helperID2 = 0;
    _helperID3 = 0;
    _customerID = 0;
    _customerList = [];
    _projectID = 0;
    _projectsList = [];
    _originID = 0;
    _originList = [];
    _truckID = 0;
    _truckList = [];
    _companyManID = 0;
    _companyManList = [];
    _destinationID = 0;
    _destinationList = [];
    _loadOldTickets = true;
    _dataLoad = true;
    _btnController1 = RoundedLoadingButtonController();
    connectionManagerController = Get.put(ConnectionManagerController());
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    if (_loadOldTickets == true) {
      if (AccountPrefs.statusConnection == true) {
        await getCustomers();
        await getDestinations();
        await getOrigins();
        await getShift();
        await getTrucks();
        await downloadDataToApp();
      } else {
        await getCustomersNOTWIFI();
        await getDestinationsNOTWIFI();
        await getOriginsNOTWIFI();
        await getShiftNOTWIFI();
        await getTrucksNOTWIFI();
      }

      _loadOldTickets = false;
      _dataLoad = false;
      update();
    }
    if (_customerID > 0) {
      AccountPrefs.statusConnection == true
          ? await getProjects()
          : await getProjectsByIDNOTWifi();
    }
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<AddNewTicketController>();
    super.onClose();
  }

  selectProject(id) async {
    _projectID = id;
    AccountPrefs.statusConnection == true
        ? await getCompanyMen()
        : await getCompanyMenNOTWIFI();
    update();
  }

  selectCustomer(value) async {
    _customerID = int.parse(value[0].toString());
    _customerSelected = value[1];
    AccountPrefs.statusConnection == true
        ? await getProjects()
        : await getProjectsByIDNOTWifi();
    update();
  }

  selectOrigin(id) {
    _originID = id;
    update();
  }

  selectDestination(id) {
    _destinationID = id;
    update();
  }

  selectTruck(id) async {
    _truckID = id;
    update();
  }

  selectCompanyMan(id) async {
    _companyManID = id;
    update();
  }

  /*
  Create new Ticket
 */
  createNewTicket() async {
    try {
      //await _getShift();
      final String urlApi = '${api.api}/${api.createTicket}';

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final body = {
        'shift_id': AccountPrefs.currentShift,
        'company_man_id': _companyManID,
        'customer': _customerSelected,
        'customer_id': _customerID,
        'destination_id': _destinationID,
        'project_id': _projectID,
        'date': formatDate,
        'equipment_id':
            _truckID, //_equipmentID, //review how to get this value from the app
        'worker_id': AccountPrefs.idUser,
        'helper_id': _helperID,
        'helper2_id': _helperID2,
        'helper3_id': _helperID3,
        'depart_timestamp': null,
        'arrived_timestamp': null,
        'finished_timestamp': null,
        'arrived_photo': null,
        'finished_photo': null,
        'description': null,
        'worker_type_id': AccountPrefs.workerTypeID,
      };

      final response = AccountPrefs.statusConnection == true
          ? await http.post(Uri.parse(urlApi),
              headers: header, body: json.encode(body))
          : await TicketsSQL().insertTicketFromAppSQL(body);
      Map<String, dynamic>? decodeResp;
      if (AccountPrefs.statusConnection == true) {
        decodeResp = json.decode(response.body);
      }

      // print(decodeResp['data'].containsKey('ticketID'));
      if (AccountPrefs.statusConnection == true) {
        if (response.statusCode == 200 && decodeResp!['success'] == true) {
          if (decodeResp['data'].containsKey('ticketID')) {
            AccountPrefs.hasOpenTicke = decodeResp['data']['ticketID'];
            AccountPrefs.statusTicket = 'Accepted';
            update();
            //_hasOpenTicke = decodeResp['data']['ticketID'];
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
      } else {
        if (response['statusCode'] == 200 && response['success']) {
          if (response['data'].containsKey('ticketID')) {
            AccountPrefs.hasOpenTicke = response['data']['ticketID'];
            update();
            //_hasOpenTicke = decodeResp['data']['ticketID'];
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
      }
      update();
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

  /*
   * GET info Shift Data befor create Ticket to take helpers and Equipment
   */
  getShift() async {
    try {
      final String urlApi =
          '${api.api}/${api.getCurrentShift}${AccountPrefs.idUser}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print(decodeResp['data']);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp['data'].length > 0) {
          late List dataObject = decodeResp['data'] as List;
          print(dataObject[0]);
          ShiftModel shift = ShiftModel.fromJson(dataObject.first);
          print(shift);
          _equipmentID = shift.equipmentId;
          _helperID = shift.helper;
          _helperID2 = shift.helper2;
          _helperID3 = shift.helper3;
          update();
        }
      } else {
        Get.snackbar(
            'Warning', 'Please try it later, we not found data. About Shift',
            colorText: Colors.white,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getShiftNOTWIFI() async {
    try {
      final response =
          await ShiftSQL().getActiveShiftSQL(AccountPrefs.currentShift);

      //Map<String, dynamic> decodeResp = json.decode(response.body);
      //print(decodeResp['data']);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          // late List dataObject = response['data'] as List;
          // print(dataObject[0]);
          ShiftModel shift = response['data'];
          // ShiftModel.fromJson(dataObject.first);
          print(shift);
          _equipmentID = shift.equipmentId;
          _helperID = shift.helper;
          _helperID2 = shift.helper2;
          _helperID3 = shift.helper3;
          update();
        }
      } else {
        Get.snackbar(
            'Warning', 'Please try it later, we not found data. About Shift',
            colorText: Colors.white,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /*
   * load customers, projects, origins and destiantion
   */

  getCustomers() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.getCustomers}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print(decodeResp);
      if (decodeResp['message'] == 'Unauthenticated') {
        return false;
      }
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          _customerList = (decodeResp['data'] as List)
              .map((e) => CustomerModel.fromJson(e))
              .toList();
        } else {
          _customerList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. Customers',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _customerList = [];
      }
      update();
      return _customerList;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Customers',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _customerList = [];
    }
  }

  getCustomersNOTWIFI() async {
    try {
      //loading dialog

      final response = await CustomerSQL().getCustomersSQL();

      //Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List customerListCome = response['data'] as List;
          for (var element in customerListCome) {
            _customerList.add(element);
          }
          // _customerList = (response['data'] as List)
          //     .map((e) => CustomerModel.fromJson(e))
          //     .toList();
        } else {
          _customerList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _customerList = [];
      }
      update();
      return _customerList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _customerList = [];
    }
  }

  getOrigins() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.origins}'; //url/api/login

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
          _originList = (decodeResp['data'] as List)
              .map((e) => DestinyOriginModel.fromJson(e))
              .toList();
        } else {
          _originList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. origins',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _originList = [];
      }
      update();
      return _originList;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. origins',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _originList = [];
    }
  }

  getOriginsNOTWIFI() async {
    try {
      final response = await OriginsSQL().getOriginsSQL();

      // Map<String, dynamic> decodeResp = json.decode(response.body);
      // print(decodeResp);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List originListCome = response['data'] as List;
          for (var element in originListCome) {
            _originList.add(element);
          }
          // _originList = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          _originList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _originList = [];
      }
      update();
      return _originList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _originList = [];
    }
  }

  getDestinations() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.destinations}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      print('Destination ticket url => $urlApi');
      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print('Destination ticket => $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          _destinationList = (decodeResp['data'] as List)
              .map((e) => DestinyOriginModel.fromJson(e))
              .toList();
        } else {
          _destinationList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. Destinations',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _destinationList = [];
      }
      update();
      return _destinationList;
    } catch (e) {
      print(e.toString());
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Destinations',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _destinationList = [];
    }
  }

  getDestinationsNOTWIFI() async {
    try {
      //loading dialog

      final response = await DestinationsSQL().getOriginsSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List originListCome = response['data'] as List;
          for (var element in originListCome) {
            _destinationList.add(element);
          }
          // _destinationList = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          _destinationList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _destinationList = [];
      }
      update();
      return _destinationList;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _destinationList = [];
    }
  }

  getProjects() async {
    try {
      final String urlApi =
          '${api.api}/${api.getProjectsInApp}$_customerID'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print(decodeResp['data']);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          _projectsList = (decodeResp['data'] as List)
              .map((e) => ProjectModel.fromJson(e))
              .toList();
        } else {
          _projectsList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data of Projects.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _projectsList = [];
      }
      return _projectsList;
    } catch (e) {
      print(e.toString());
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Projects',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _projectsList = [];
    }
  }

  //projects with out internet
  getProjectsByIDNOTWifi() async {
    try {
      final response = await ProjectsSQL().getProjectsSQL(_customerID);

      //Map<String, dynamic> decodeResp = response;
      //print(decodeResp['data']);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List projectsCome = response['data'] as List;
          if (kDebugMode) {
            print(projectsCome);
          }
          _projectsList = [];
          // _projectsList =
          //     (projectsCome).map((e) => ProjectModel.fromJson(e)).toList();
          for (var element in projectsCome) {
            _projectsList.add(element);
          }
        } else {
          _projectsList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data of Projects.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _projectsList = [];
      }
      return _projectsList;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _projectsList = [];
    }
  }

  getAllProjects() async {
    List<ProjectModel> listProjectsAll = [];
    try {
      final String urlApi =
          '${api.api}/${api.getAllProjectsInApp}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print(decodeResp['data']);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listProjectsAll = (decodeResp['data'] as List)
              .map((e) => ProjectModel.fromJson(e))
              .toList();
        } else {
          listProjectsAll = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning',
            'Please try it later, we dont found data of Projects. all Projects',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listProjectsAll = [];
      }
      return listProjectsAll;
    } catch (e) {
      print(e.toString());
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. all Projects',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return listProjectsAll = [];
    }
  }

  getTrucks() async {
    try {
      final String urlApi = '${api.api}/${api.trucks}'; //url/api/login

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
          _truckList = (decodeResp['data'] as List)
              .map((e) => EquipmentModel.fromJson(e))
              .toList();
        } else {
          _truckList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. Trucks',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _truckList = [];
      }
      update();
      return _truckList;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Trucks',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _truckList = [];
    }
  }

  getTrucksNOTWIFI() async {
    try {
      final response = await EquipmentSQL().getEquipmentTrucksSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List truckListCome = response['data'] as List;
          for (var element in truckListCome) {
            _truckList.add(element);
          }
        } else {
          _truckList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _truckList = [];
      }
      update();
      return _truckList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _originList = [];
    }
  }

  getCompanyMen() async {
    try {
      final String urlApi =
          '${api.api}/${api.companyMenByCustomer}$_customerID'; //url/api/login

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
          _companyManList = (decodeResp['data'] as List)
              .map((e) => CompanyManModel.fromJson(e))
              .toList();
        } else {
          _companyManList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. Company Man',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _companyManList = [];
      }
      update();
      return _companyManList;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Company man',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _companyManList = [];
    }
  }

  getCompanyMenAll() async {
    try {
      final String urlApi = '${api.api}/${api.companyMen}'; //url/api/login

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
          _companyManList = (decodeResp['data'] as List)
              .map((e) => CompanyManModel.fromJson(e))
              .toList();
        } else {
          _companyManList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we dont found data. Company Man',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _companyManList = [];
      }
      update();
      return _companyManList;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Company man',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _companyManList = [];
    }
  }

  getCompanyMenNOTWIFI() async {
    try {
      final response =
          await CompanyMenSQL().getCompanyMenSQLByCostumer(_customerID);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List companyManListCome = response['data'] as List;
          for (var element in companyManListCome) {
            _companyManList.add(element);
          }
        } else {
          _companyManList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _companyManList = [];
      }
      update();
      return _companyManList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _companyManList = [];
    }
  }

  downloadDataToApp() async {
    // await WorkersSQL().trucateWorkers();
    // await EquipmentSQL().trucateEquipment();
    await OriginsSQL().trucateOrigins();
    await DestinationsSQL().trucateOrigins();
    //await TicketsSQL().trucateTicketFinisheds();
    await CustomerSQL().trucateCustomer();
    await ProjectsSQL().trucateProjects();
    // await TicketDescriptionSQL().trucateTicketDescription();
    await CompanyMenSQL().trucateCompanyMen();

    //origin
    List<DestinyOriginModel> listOrigin = [];
    listOrigin = await getOrigins();
    if (listOrigin.isNotEmpty) {
      for (var element in listOrigin) {
        await OriginsSQL().insert(element);
      }
      if (kDebugMode) {
        print('All ORigins are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  ORigins to sqlite');
      }
    }

    //destinations
    List<DestinyOriginModel> listDestinations = [];
    listDestinations = await getDestinations();
    if (listDestinations.isNotEmpty) {
      for (var element in listDestinations) {
        await DestinationsSQL().insert(element);
      }
      if (kDebugMode) {
        print('All Destinations are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  Destinations to sqlite');
      }
    }

    //customer
    List<CustomerModel> listCutomer = [];
    listCutomer = await getCustomers();
    if (listCutomer.isNotEmpty) {
      for (var element in listCutomer) {
        await CustomerSQL().insert(element);
      }
      if (kDebugMode) {
        print('All Customers are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  Customers to sqlite');
      }
    }
    //projects
    List<ProjectModel> listProject = [];
    listProject = await getAllProjects();
    if (listProject.isNotEmpty) {
      for (var element in listProject) {
        await ProjectsSQL().insert(element);
      }
      if (kDebugMode) {
        print('All projects are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  projects to sqlite');
      }
    }
    //companyMan
    List<CompanyManModel> listCompanyMan = [];
    listCompanyMan = await getCompanyMenAll();
    if (listCompanyMan.isNotEmpty) {
      for (var element in listCompanyMan) {
        await CompanyMenSQL().insert(element);
      }
      if (kDebugMode) {
        print('All Company Man are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  Company Man to sqlite');
      }
    }
    //END FUNC
  }
}
