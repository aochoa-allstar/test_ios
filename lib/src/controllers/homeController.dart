import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/src/controllers/addNewTicketController.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/controllers/createShiftController.dart';
import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/repositories/models/companyManModel.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/repositories/models/desty_origin_Model.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/projectModel.dart';
import 'package:onax_app/src/repositories/models/shiftModel.dart';
import 'package:onax_app/src/repositories/models/ticketDescriptionsModel.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/repositories/models/workersModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_company_men.dart';
import 'package:onax_app/src/services/sqlite/sqlite_customer.dart';
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_equipment.dart';
import 'package:onax_app/src/services/sqlite/sqlite_inspections.dart';
import 'package:onax_app/src/services/sqlite/sqlite_jsas.dart';
import 'package:onax_app/src/services/sqlite/sqlite_origins.dart';
import 'package:onax_app/src/services/sqlite/sqlite_project.dart';
import 'package:onax_app/src/services/sqlite/sqlite_shift.dart';
import 'package:onax_app/src/services/sqlite/sqlite_ticketDescription.dart';
import 'package:onax_app/src/services/sqlite/sqlite_tickets.dart';
import 'package:onax_app/src/services/sqlite/sqlite_workers.dart';

import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/views/components/home/creatTicket/createTicket.dart';
import 'package:onax_app/src/views/components/steperTicket/steperTicketHome.dart';
import 'package:onax_app/src/views/pages_screen.dart';

import '../utils/urlApi/globalApi.dart';
import '../views/components/home/shift/create_new_shift.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  PreferencesService storage = Get.find();
  
  final GlobalApi api = GlobalApi();
  late int _statusShiftTicket;
  late int _hasOpenTicke;
  late bool _loadOldTickets;
  late dynamic _scrollController;
  late List<TicketModel> _listPrevTickets;

  //FUNCITIONS CONTROLLERS
  // final ConnectionManagerController connectionManagerController =
  //     Get.put(ConnectionManagerController());
  late ConnectionManagerController connectionManagerController;

  late var shiftController = Get.put(CreateShiftController());
  late var addTicketController = Get.put(AddNewTicketController());
  late bool _dataLoad;

  ///get
  int get statusShiftTicket => _statusShiftTicket;
  int get hasOpenTicke => _hasOpenTicke;
  bool get loadOldTickets => _loadOldTickets;
  dynamic get scrollController => _scrollController;
  List<TicketModel> get listPrevTickets => _listPrevTickets;
  bool get dataLoad => _dataLoad;

  @override
  void onInit() async {
    connectionManagerController = Get.put(ConnectionManagerController());
    print('Connection Type => ${connectionManagerController.connectionType}');
    print(AccountPrefs.currentShift);
    _dataLoad = true;
    _statusShiftTicket =
        AccountPrefs.currentShift == 0 ? 0 : AccountPrefs.currentShift;
    _hasOpenTicke =
        AccountPrefs.hasOpenTicke == 0 ? 0 : AccountPrefs.hasOpenTicke;
    _loadOldTickets = true;
    _scrollController = ScrollController();

    _listPrevTickets = [];

    super.onInit();
  }

  @override
  void onReady() async {
    if (AccountPrefs.statusConnection == true) {
      await uploadDataToServer();
      await downloadDataToApp();
    }

    if (AccountPrefs.statusConnection == true) {
      await getShift();
      await getTicketOpen();
      await getPreviewTickts();
    } else {
      await getShiftSQL();
      await getTicketOpenNOTWifi();
      await getPreviewTicktsNotWifi();
    }

    _dataLoad = false;
    update();
    // if (_hasOpenTicke == 0) {
    //   await _getTicketOpen();
    // }

    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<HomeController>();
    super.onClose();
  }

  moveToStartShift() {
    //Get.off('/newShift');
    return Get.offAll(
      () => CreateNewShiftFormScrenn(
          //controller: Get.find<HomeController>(),
          ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  moveToSeeTheCurrentTicket() {
    //send to page Ticket with TicketController
    return Get.off(
      () => SteperTicketHome(),
      arguments: {"id": _hasOpenTicke},
      transition: Transition.upToDown,
      duration: const Duration(milliseconds: 250),
    );
  }

  moveToScreenCreateTicket() {
    return Get.off(
      () => CreateTicketForm(
          //controller: Get.find<HomeController>(),
          ),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 250),
    );
  }

/*
 * GET info from current Shift open or active 
 */
  getShift() async {
    try {
      //first verify if we have a ticket open local
      // final responsSQL =
      //     await ShiftSQL().getActiveShiftSQL(AccountPrefs.currentShift);
      //if (responsSQL['data'] == null) {
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
          // print(dataObject[0]);
          ShiftModel shift = ShiftModel.fromJson(dataObject.first);
          // print(shift);
          AccountPrefs.currentShift = shift.id;
          _statusShiftTicket = shift.id;
          update();
          final responsSQL =
              await ShiftSQL().getActiveShiftSQL(AccountPrefs.currentShift);
          if (responsSQL['data'] == null) {
            await ShiftSQL().insertShiftFromServerSQL(shift);
          }
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, we not found information. Shift Active',
            colorText: Colors.white,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
      // }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. Shift Active',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getShiftSQL() async {
    try {
      final response =
          await ShiftSQL().getActiveShiftSQL(AccountPrefs.currentShift);

      // Map<String, dynamic> decodeResp = response;
      //print(decodeResp['data']);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          //late List dataObject = decodeResp['data'] as List;
          // print(dataObject[0]);
          ShiftModel shift =
              response['data']; //ShiftModel.fromJson(dataObject.first);
          // print(shift);AccountPrefs.hasOpenTicke = ticket.id != 0 ? ticket.id : ticket.idKey;
          AccountPrefs.currentShift = shift.id != 0 ? shift.id : shift.idKey;
          _statusShiftTicket = shift.id != 0 ? shift.id : shift.idKey;
          update();
        }
      } else {
        Get.snackbar(
            'Warning', 'Please try it later, we not found information.',
            colorText: Colors.black,
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

  //load & get previews tickets
  getPreviewTickts() async {
    try {
      print(AccountPrefs.type);
      //loading dialog
      // if (AccountPrefs.type == 'driver' ||
      //     AccountPrefs.type == 'operator' ||
      //     AccountPrefs.type == 'pusher') {
      final String urlApi =
          '${api.api}/${api.getPrevTickets}${AccountPrefs.idUser}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          _listPrevTickets = (decodeResp['data'] as List)
              .map((e) => TicketModel.fromJson(e))
              .toList();
        } else {
          _listPrevTickets = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning',
            'Please try it later, we can not connect with the app. Prev Tickts',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listPrevTickets = [];
      }
      update();
      //}
      return _listPrevTickets;
    } catch (e) {
      Get.snackbar(
          'Error', 'There was a problem connecting to the server. PrevTickts',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listPrevTickets = [];
      return _listPrevTickets;
    }
  }

  getPreviewTicktsNotWifi() async {
    try {
      print(AccountPrefs.type);
      //loading dialog
      // if (AccountPrefs.type == 'driver' ||
      //     AccountPrefs.type == 'operator' ||
      //     AccountPrefs.type == 'pusher') {
      final response = await TicketsSQL().getPrevTicketsFinishedsSQL();

      //Map<String, dynamic> decodeResp = response;

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List prevTickts = response['data'] as List;
          _listPrevTickets = [];
          for (var element in prevTickts) {
            _listPrevTickets.add(element);
          }
          // _listPrevTickets = (decodeResp['data'] as List)
          //     .map((e) => TicketModel.fromJson(e))
          //     .toList();
        } else {
          _listPrevTickets = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'You dont have previous tickets yet.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _listPrevTickets = [];
      }
      update();
      // }
      return _listPrevTickets;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _listPrevTickets = [];
      return _listPrevTickets;
    }
  }

  _loadPreviewTickets() async {}

  /*
   * GET InfoTicket Open
   */
  getTicketOpen() async {
    try {
      final String urlApi = '${api.api}/${api.getInfoOpenTicket}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      print('shift => $_statusShiftTicket');

      final body = {
        'worker_id': AccountPrefs.idUser,
        'shift_id': _statusShiftTicket,
      };
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));
      Map<String, dynamic> decodeResp = json.decode(response.body);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        // if (decodeResp['data'].length > 0) {
        //late List<dynamic> dataObject = decodeResp['data'];
        //print(dataObject[0]);
        TicketModel ticket = TicketModel.fromJson(decodeResp['data']);

        AccountPrefs.hasOpenTicke = ticket.id;
        AccountPrefs.hasOpenTicketPrefix = ticket.prefix;
        if (ticket.deparmentTimesTimep != '') {
          AccountPrefs.statusTicket = 'departed';
        } else if (ticket.arrivedTimesTimep != '') {
          AccountPrefs.statusTicket = 'arrived';
        } else if (ticket.finishedTimesTimep != '') {
          AccountPrefs.statusTicket = 'finished';
        } else {
          AccountPrefs.statusTicket = 'inactive_ticket';
        }
        _hasOpenTicke = ticket.id;
        update();
        // insert ticket in tickets SQL
        final responsSQL = await TicketsSQL().getActiveTicketSQL(ticket.id);
        if (responsSQL['data'] == null) {
          await TicketsSQL().insertTicketsSQL(ticket);
        }
        //}
      }
      // else {
      //   Get.snackbar('warinig',
      //       'Please try it later, we not found information. Of ticket open',
      //       colorText: Colors.black,
      //       backgroundColor: Colors.yellow,
      //       snackPosition: SnackPosition.BOTTOM);
      // }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server.Get info ticket open',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getTicketOpenNOTWifi() async {
    try {
      //  await TicketsSQL().getAllTicketsSQLITE();
      final response =
          await TicketsSQL().getActiveTicketSQL(AccountPrefs.hasOpenTicke);
      // Map<String, dynamic> decodeResp = response;
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          late List dataObject = response['data'] as List;
          //print(dataObject[0]);
          TicketModel ticket =
              response['data']; //TicketModel.fromJson(dataObject.first);

          AccountPrefs.hasOpenTicke = ticket.id != 0 ? ticket.id : ticket.idKey;
          _hasOpenTicke = AccountPrefs.hasOpenTicke;
          if (ticket.deparmentTimesTimep != '') {
            AccountPrefs.statusTicket = 'departed';
          } else if (ticket.arrivedTimesTimep != '') {
            AccountPrefs.statusTicket = 'arrived';
          } else if (ticket.finishedTimesTimep != '') {
            AccountPrefs.statusTicket = 'finished';
          } else {
            AccountPrefs.statusTicket = 'inactive_ticket';
          }
          update();
          // insert ticket in tickets SQL
          // final responsSQL = await TicketsSQL().getActiveTicketSQL(ticket.id);
          // if (responsSQL['data'].length == 0) {
          //   await TicketsSQL().insertTicketsSQL(ticket);
          // }
        }
      }
      // else {
      //   Get.snackbar('warinig',
      //       'Please try it later, we not found information. Of ticket open',
      //       colorText: Colors.black,
      //       backgroundColor: Colors.yellow,
      //       snackPosition: SnackPosition.BOTTOM);
      // }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server.Get info ticket',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  uploadDataToServer() async {
    //review if we have to delete tickets table.
    await ShiftSQL().uploadShiftsToServer();
    await TicketsSQL().uploadTicketToServerAllFinisheds();
    await JsasSQL().uploadJSASToServer();
    await InspectionsSQL().uploadInspectionsToServer();
  }

  downloadDataToApp() async {
    // await WorkersSQL().trucateWorkers();
    // await EquipmentSQL().trucateEquipment();
    // await OriginsSQL().trucateOrigins();
    // await DestinationsSQL().trucateOrigins();
    await TicketsSQL().trucateTicketFinisheds();
    // await CustomerSQL().trucateCustomer();
    // await ProjectsSQL().trucateProjects();
    // await TicketDescriptionSQL().trucateTicketDescription();
    // await CompanyMenSQL().trucateCompanyMen();

    //Projects
    //workers truncate and download
    // await shiftController.getHelpers();
    var data = await WorkersSQL().getWorkersSQL();
    List<WorkerModel> listWokersSQL = data['data'] != null ? data['data'] : [];
    if (listWokersSQL.isEmpty) {
      List<WorkerModel> listWorkers = await shiftController.getHelpers();
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
    }

    //equipment trucante and download
    var dataEquip = await EquipmentSQL().getALLEquipmentSQL();
    List<EquipmentModel> listEquipmentSQL =
        dataEquip['data'] != null ? dataEquip['data'] : [];

    if (listEquipmentSQL.isEmpty) {
      List<EquipmentModel> listEquipment = [];
      listEquipment = await shiftController.getEquipments();
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

    // origins trucante and download
    var dataOrigin = await OriginsSQL().getOriginsSQL();
    List<DestinyOriginModel> listOriginSQL =
        dataOrigin['data'] != null ? dataOrigin['data'] : [];
    if (listOriginSQL.isEmpty) {
      List<DestinyOriginModel> listOrigin = [];
      listOrigin = await addTicketController.getOrigins();
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
    }

    // destinations trucante and download
    var dataDestination = await DestinationsSQL().getOriginsSQL();
    List<DestinyOriginModel> listDestinationsSQL =
        dataDestination['data'] != null ? dataDestination['data'] : [];

    if (listDestinationsSQL.isEmpty) {
      List<DestinyOriginModel> listDestinations = [];
      listDestinations = await addTicketController.getDestinations();
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
    }

    // projects truncate and download
    // tickets finisheds truncate and download
    // List<TicketModel> listTicketFinishedSQL =
    //     await TicketsSQL().getPrevTicketsFinishedsSQL();
    // if (listTicketFinishedSQL.isEmpty) {
    List<TicketModel> listTicketFinished = [];
    listTicketFinished = await getPreviewTickts();
    if (listTicketFinished.isNotEmpty) {
      for (var element in listTicketFinished) {
        await TicketsSQL().insertTicketsFinishedSQL(element);
      }
      if (kDebugMode) {
        print('All finishedTickets are in sqlite');
      }
    } else {
      if (kDebugMode) {
        print('Nothing  finishedTickets to sqlite');
      }
    }
    // }

    // Customers truncate and download
    var dataCustomer = await CustomerSQL().getCustomersSQL();
    List<CustomerModel> listCutomerSQL =
        dataCustomer['data'] != null ? dataCustomer['data'] : [];
    if (listCutomerSQL.isEmpty) {
      List<CustomerModel> listCutomer = [];
      listCutomer = await addTicketController.getCustomers();
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
    }

    // project truncate and dowload
    var dataProjects = await ProjectsSQL().getALLProjectsSQL();
    List<ProjectModel> listProjectSQL =
        dataProjects['data'] != null ? dataProjects['data'] : [];
    if (listProjectSQL.isEmpty) {
      List<ProjectModel> listProject = [];
      listProject = await addTicketController.getAllProjects();
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
    }

    //ticketDescriptions
    var dataTicketsDescr =
        await TicketDescriptionSQL().getTicketDescriptionsSQL();
    List<TicketDescriptionsModel> listDescriptSQL =
        dataTicketsDescr['data'] != null ? dataTicketsDescr['data'] : [];

    if (listDescriptSQL.isEmpty) {
      List<TicketDescriptionsModel> listDescription = [];
      listDescription = await _getTicketDescription();
      if (listDescription.isNotEmpty) {
        for (var element in listDescription) {
          await TicketDescriptionSQL().insert(element);
        }
        if (kDebugMode) {
          print('All TicketDescriptions are in sqlite');
        }
      } else {
        if (kDebugMode) {
          print('Nothing  TicketDescriptions to sqlite');
        }
      }
    }

    // company men trucante and download
    var dataCompany = await CompanyMenSQL().getCompanyMenSQL();
    List<CompanyManModel> listComanyManSQL =
        dataCompany['data'] != null ? dataCompany['data'] : [];

    if (listComanyManSQL.isEmpty) {
      List<CompanyManModel> listCompanyMan = [];
      listCompanyMan = await addTicketController.getCompanyMenAll();
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
    }
    //END FUNC
  }

  //GET DESCRIPTS
  _getTicketDescription() async {
    List<TicketDescriptionsModel> listDescriptionsModel = [];
    try {
      //loading dialog

      final String urlApi =
          '${api.api}/${api.getAllTicketDescr}'; //url/api/login

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
          listDescriptionsModel = [];
          listDescriptionsModel = (decodeResp['data'] as List)
              .map((e) => TicketDescriptionsModel.fromJson(e))
              .toList();
        } else {
          listDescriptionsModel = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning',
            'Please try it later, we dont found data. ticket Descriptions',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listDescriptionsModel = [];
      }
      // update();
      return listDescriptionsModel;
    } catch (e) {
      Get.snackbar('Error',
          'There was a problem connecting to the server. ticket Descriptions',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return listDescriptionsModel = [];
    }
  }

  //END CLASS
}
