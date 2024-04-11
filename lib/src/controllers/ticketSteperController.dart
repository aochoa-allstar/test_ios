import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/controllers/listJsasController.dart';
import 'package:onax_app/src/repositories/models/desty_origin_Model.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/jsasModel.dart';
import 'package:onax_app/src/repositories/models/supervisorModel.dart';
import 'package:onax_app/src/repositories/models/ticketDescriptionsModel.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:http/http.dart' as http;
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_shift.dart';
import 'package:onax_app/src/services/sqlite/sqlite_ticketDescription.dart';
import 'package:onax_app/src/services/sqlite/sqlite_tickets.dart';
import 'package:onax_app/src/views/JsasFormScreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../utils/sharePrefs/accountPrefs.dart';
import '../utils/urlApi/globalApi.dart';

class TicketSteperController extends GetxController {
  final GlobalApi api = GlobalApi();
  late int _currentSteperIndex;
  late String? _departTimestamp;
  late String? _arrivedTimestamp;
  late String? _finishedTimestamp;
  late String _descriptionText;
  late String _arrivedPhoto;
  late String _finishedPhoto;
  late ImagePicker _picker;
  File? _imgFinish = null;
  File? _imgArrive = null;
  late int? _ticketId;
  late String _dateTicket;
  late TicketModel? _currentTicket;
  late List<DestinyOriginModel> _listDestinations;
  late List<TicketDescriptionsModel> _listDescriptions;
  late int _departSelected;
  late bool _loadTicketForm;
  late bool _loadByAction;
  late RoundedLoadingButtonController _btnDepart;
  late RoundedLoadingButtonController _btnArrrived;
  late RoundedLoadingButtonController _btnfinished;
  late RoundedLoadingButtonController _btnEndShift;
  late int counterFails;
  late TextEditingController descriptionControlText;

  late int _supervisorID;
  late List<SupervisorModel> _supervisorList;
  late String _workHours, _supervisorWorkHours;
  late int _additionalEquipmentID;
  late List<EquipmentModel> _additionalEquipmentList;
  late List<int> _additionalEquipmentIDs;
  late List<String> _additionalEquipmentNames;

  final ListJSasController jsasController = ListJSasController();
  final didCompleteJSA = Rx<bool>(false);
  final btnFillJSA =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  //GETERS
  File? get imgFinish => _imgFinish;
  File? get imgArrive => _imgArrive;
  ImagePicker get picker => _picker;
  int get currentSteperIndex => _currentSteperIndex;
  String? get departTimestamp => _departTimestamp;
  String? get arrivedTimestamp => _arrivedTimestamp;
  String? get finishedTimestamp => _finishedTimestamp;
  TicketModel? get currentTicket => _currentTicket;
  int get departSelected => _departSelected;
  int? get ticketId => _ticketId;
  String get dateTicket => _dateTicket;
  bool get loadTicketForm => _loadTicketForm;
  bool get loadByAction => _loadByAction;
  String get descriptionText => _descriptionText;
  List<DestinyOriginModel> get listDestinations => _listDestinations;
  List<TicketDescriptionsModel> get listDescriptions => _listDescriptions;
  RoundedLoadingButtonController get btnDepart => _btnDepart;
  RoundedLoadingButtonController get btnArrrived => _btnArrrived;
  RoundedLoadingButtonController get btnfinished => _btnfinished;
  RoundedLoadingButtonController get btnEndShift => _btnEndShift;

  int get supervisorID => _supervisorID;
  List<SupervisorModel> get supervisorList => _supervisorList;
  String get workHours => _workHours;
  String get supervisorWorkHours => _supervisorWorkHours;
  int get additionalEquipmentID => _additionalEquipmentID;
  List<EquipmentModel> get additionalEquipmentList => _additionalEquipmentList;
  List<int> get additionalEquipmentIDs => _additionalEquipmentIDs;
  List<String> get additionalEquipmentNames => _additionalEquipmentNames;

  late ConnectionManagerController connectionManagerController;
  @override
  void onInit() {
    counterFails = 0;
    // TODO: implement onInit
    _loadByAction = true;
    _loadTicketForm = true;
    _dateTicket = '';
    _descriptionText = '';
    _arrivedPhoto = '';
    _finishedPhoto = '';
    _currentSteperIndex = 0;
    _departSelected = 0;
    _departTimestamp = null;
    _arrivedTimestamp = null;
    _finishedTimestamp = null;
    _currentTicket = null;
    _listDestinations = [];
    _listDescriptions = [];
    _ticketId = Get.arguments['id'];
    _btnEndShift = RoundedLoadingButtonController();
    _btnArrrived = RoundedLoadingButtonController();
    _btnfinished = RoundedLoadingButtonController();
    _btnDepart = RoundedLoadingButtonController();
    descriptionControlText = TextEditingController();
    connectionManagerController = Get.put(ConnectionManagerController());

    _supervisorID = 0;
    _supervisorList = [];
    _workHours = '';
    _supervisorWorkHours = '';
    _additionalEquipmentID = 0;
    _additionalEquipmentList = [];
    _additionalEquipmentIDs = [];
    _additionalEquipmentNames = [];
    getJSAStatus(AccountPrefs.statusConnection, ticketId!);

    super.onInit();
  }

  @override
  void onReady() async {
    if (AccountPrefs.statusConnection == true) {
      await _getTicketActive();
      // getJSAStatus(AccountPrefs.statusConnection, ticketId!);
      if (_loadTicketForm == true) {
        await downloadDataToApp();
        await _getDestinations();
        await _getTicketDescription();

        _loadTicketForm = false;
        await getSupervisors();
        await getAdditionalEquipment();
        update();
      }
    } else {
      await _getTicketActiveNotWifi();
      // await getJSAStatus(AccountPrefs.statusConnection, ticketId!);
      if (_loadTicketForm == true) {
        await _getDestinationsNotWifi();
        await _getTicketDescriptionNotWifi();
        _loadTicketForm = false;
        update();
      }
    }

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<TicketSteperController>();
    super.onClose();
  }

  //type 1 == Arrive 2 == finish
  takePic(int type) async {
    _picker = ImagePicker();
    _arrivedPhoto = '';
    _finishedPhoto = '';
    _imgArrive = null;
    _imgFinish = null;
    update();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
        preferredCameraDevice: CameraDevice.rear);
    switch (type) {
      case 1:
        _imgArrive = File(image!.path);
        Uint8List? imageBytes = await _imgArrive?.readAsBytes();
        _arrivedPhoto = base64.encode(imageBytes!);
        print(_arrivedPhoto);
        update();
        break;
      case 2:
        _imgFinish = File(image!.path);
        Uint8List? imageBytes = await _imgFinish?.readAsBytes();
        _finishedPhoto = base64.encode(imageBytes!);
        print(_finishedPhoto);
        update();
        break;
      default:
    }
    Get.back();
  }

  fromGallery(int type) async {
    _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    switch (type) {
      case 1:
        _imgArrive = File(image!.path);
        print('PATH => $_imgArrive');
        Uint8List? imageBytes = await _imgArrive?.readAsBytes();
        _arrivedPhoto = base64.encode(imageBytes!);
        print(_arrivedPhoto);
        update();
        break;
      case 2:
        _imgFinish = File(image!.path);
        print('PATH => $_imgFinish');
        Uint8List? imageBytes = await _imgFinish?.readAsBytes();
        _finishedPhoto = base64.encode(imageBytes!);
        print(_finishedPhoto);
        update();
        break;
      default:
    }
    Get.back();
  }

  _updateInfoTicket(TicketModel ticket) {
    _currentTicket = ticket;
    _arrivedTimestamp = ticket.arrivedTimesTimep;

    _departTimestamp = ticket.deparmentTimesTimep;

    _finishedTimestamp = ticket.finishedTimesTimep;

    _departSelected = ticket.destinationId > 0 ? ticket.destinationId : 1;

    //late String dateFormat = ticket.date;
    _dateTicket = ticket.date;
    if (_departTimestamp != '') {
      _currentSteperIndex = 1;
    }
    if (_arrivedTimestamp != '') {
      _currentSteperIndex = 2;
    }

    update();
  }

  selectDescription(val) {
    _descriptionText = val[1];
    descriptionControlText.text = _descriptionText;
    update();
  }

  setSupervisor(id) {
    _supervisorID = id;
    update();
  }

  setSupervisorWorkHours(val) {
    _supervisorWorkHours = val;
    update();
  }

  setWorkHours(val) {
    _workHours = val;
    update();
  }

  setAdditionalEquipment(id) {
    _additionalEquipmentID = id;
    update();
  }

  setAdditionalEquipmentIDs(ids) {
    _additionalEquipmentIDs = ids;
    update();
  }

  steperCompleted(int step) {
    print(step);
    if (step > _currentSteperIndex) {
      if (_currentSteperIndex == 0 && _departTimestamp != '') {
        _currentSteperIndex = step;
      }
      if (_currentSteperIndex == 1 && _arrivedTimestamp != '') {
        _currentSteperIndex = step;
      }
      if (_currentSteperIndex == 2 && _finishedTimestamp != '') {
        _currentSteperIndex = step;
      }
    }
    if (step < _currentSteperIndex) {
      _currentSteperIndex = step;
    }
    update();
  }

  _getTicketActive() async {
    try {
      print(AccountPrefs.hasOpenTicke);
      final String urlApi =
          '${api.api}/${api.getTicketActive}${AccountPrefs.hasOpenTicke}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(
        Uri.parse(urlApi),
        headers: header,
      );
      Map<String, dynamic> decodeResp = json.decode(response.body);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        //if (decodeResp['data'].length > 0) {
        //late List dataObject = decodeResp['data'] as List;
        // print(dataObject[0]);
        TicketModel ticket = TicketModel.fromJson(decodeResp['data']);
        print(ticket.id);
        print(AccountPrefs.hasOpenTicke);

        _updateInfoTicket(ticket);
        update();
        // }
      } else {
        Get.snackbar('Warning',
            'Please try it later, we not found information. Of ticket active',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
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

  _getTicketActiveNotWifi() async {
    try {
      //AccountPrefs.hasOpenTicke
      final response =
          await TicketsSQL().getActiveTicketSQL(AccountPrefs.hasOpenTicke);
      //  Map<String, dynamic> decodeResp = json.decode(response.body);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          // late List dataObject = response['data'] as List;
          // print(dataObject[0]);
          TicketModel ticket =
              response['data']; //TicketModel.fromJson(dataObject.first);
          print(ticket.id);
          print(AccountPrefs.hasOpenTicke);

          _updateInfoTicket(ticket);
          update();
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, we not found information. Of ticket active',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
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

  _getDestinations() async {
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
          _listDestinations = (decodeResp['data'] as List)
              .map((e) => DestinyOriginModel.fromJson(e))
              .toList();
        } else {
          _listDestinations = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listDestinations = [];
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _listDestinations = [];
    }
  }

  _getDestinationsNotWifi() async {
    try {
      //loading dialog

      final response = await DestinationsSQL().getOriginsSQL();
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List destinations = response['data'] as List;
          for (var element in destinations) {
            _listDestinations.add(element);
          }
          // _listDestinations = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          _listDestinations = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listDestinations = [];
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _listDestinations = [];
    }
  }

//GET DESCRIPTS
  _getTicketDescription() async {
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
          _listDescriptions = (decodeResp['data'] as List)
              .map((e) => TicketDescriptionsModel.fromJson(e))
              .toList();
        } else {
          _listDescriptions = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listDescriptions = [];
      }
      update();
      return _listDescriptions;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _listDescriptions = [];
    }
  }

  _getTicketDescriptionNotWifi() async {
    try {
      //loading dialog

      final response = await TicketDescriptionSQL().getTicketDescriptionsSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listDecripCome = response['data'] as List;
          for (var element in listDecripCome) {
            _listDescriptions.add(element);
          }
        } else {
          _listDescriptions = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _listDescriptions = [];
      }
      update();
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _listDescriptions = [];
    }
  }

  getJSAStatus(bool hasNetwork, int ticketId) async {
    dynamic jsasResponse = await fetchJsas(GlobalApi());
    jsasResponse = json.decode(jsasResponse.body);
    List<JsasModel> jsasList = (jsasResponse['data'] as List)
        .map((e) => JsasModel.fromJson(e))
        .toList();

    if (jsasList.isNotEmpty) {
      didCompleteJSA.value =
          jsasList.firstWhere((e) => e.ticketId == ticketId) != -1
              ? true
              : false;
    } else {
      didCompleteJSA.value = false;
    }

    return;
  }

  updateJSAStatus(bool status) {
    didCompleteJSA.value = status;
  }

  redirectToJSAForm() {
    Get.to(
      () => JsasFormScreen(),
      arguments: {'ticketId': ticketId},
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    )!.then((value) => onInit());
  }

  //leftTicketDescriptionNOtWIFI

  //
  //updateDepartTime
  updateDepartTime() async {
    try {
      final String urlApi = '${api.api}/${api.updateDepartInTicket}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'id': _currentTicket?.id,
        'shift_id': AccountPrefs.currentShift,
      };
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        //if (decodeResp['data'].length > 0) {
        //late List dataObject = decodeResp['data'] as List;

        TicketModel ticket = TicketModel.fromJson(decodeResp['data']);

        // AccountPrefs.hasOpenTicke = ticket.id;
        _departTimestamp = ticket.deparmentTimesTimep;
        counterFails = 0;
        AccountPrefs.statusTicket = 'departed';
        update();
        steperCompleted(1);
        // }
      } else {
        _btnDepart.reset();
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket Depart time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await updateDepartTime();
      } else {
        await updateDepartTimeNotWifi();
        counterFails = 0;
        update();
      }
      // _btnDepart.reset();
      // print(e.toString());
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save Derpar Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
      //_btnDepart.reset();
    }
  }

  updateDepartTimeNotWifi() async {
    try {
      int ticketSend =
          _currentTicket!.id != 0 ? _currentTicket!.id : _currentTicket!.idKey;
      final response = await TicketsSQL().updateDepartTimeSQL(ticketSend);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          //late List dataObject = response['data'] as List;

          TicketModel ticket = response['data'];
          // TicketModel.fromJson(dataObject.first);

          // AccountPrefs.hasOpenTicke = ticket.id;
          _departTimestamp = ticket.deparmentTimesTimep;
          AccountPrefs.statusTicket = 'departed';
          update();
          steperCompleted(1);
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket Depart time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnDepart.reset();
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'The ticket cannot be uploaded internally.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _btnDepart.reset();
    }
  }

  //
  //updateDestination,arrivePhoto and ArrivedTimestamp
  updateArrivedInfoTicket() async {
    try {
      final String urlApi = '${api.api}/${api.updateArriveInTicket}';
      print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'id': _currentTicket?.id,
        'shift_id': AccountPrefs.currentShift,
        'arrived_photo': _arrivedPhoto,
        'destination_id': _departSelected,
      };
      if (_arrivedPhoto == '') {
        Get.snackbar('Warning', 'Please upload a picture to arrived ticket.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4));
        _btnArrrived.reset();
        return false;
      }
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        // if (decodeResp['data'].length > 0) {
        // late List dataObject = decodeResp['data'] as List;
        //print(dataObject[0]);
        TicketModel ticket = TicketModel.fromJson(decodeResp['data']);
        print('Active ticket: $ticket');
        // AccountPrefs.hasOpenTicke = ticket.id;
        _arrivedTimestamp = ticket.arrivedTimesTimep;
        counterFails = 0;
        AccountPrefs.statusTicket = 'arrived';
        update();
        steperCompleted(2);
        Get.snackbar('success', 'Photo upload successfully.',
            colorText: Colors.black,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
        // }
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket arrived time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnArrrived.reset();
        update();
      }
    } catch (e) {
      print(e.toString());
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save Arrived Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
      // _btnArrrived.reset();
      // update();
      counterFails++;
      if (counterFails < 3) {
        await updateArrivedInfoTicket();
      } else {
        await updateArrivedInfoTicketNotWifi();
        counterFails = 0;
        update();
      }
    }
  }

  updateArrivedInfoTicketNotWifi() async {
    try {
      if (_arrivedPhoto == '') {
        Get.snackbar('Warning', 'Please upload a picture to arrived ticket.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4));
        _btnArrrived.reset();
        return false;
      }
      int ticketSend =
          _currentTicket!.id != 0 ? _currentTicket!.id : _currentTicket!.idKey;
      final response = await TicketsSQL().updateArrivedInfoTicketSQL(
          ticketSend, _arrivedPhoto, _departSelected);

      //  Map<String, dynamic> decodeResp = json.decode(response.body);
      //  print('DepartTime = $decodeResp');
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          TicketModel ticket =
              response['data']; // TicketModel.fromJson(dataObject.first);
          print('Active ticket: $ticket');
          // AccountPrefs.hasOpenTicke = ticket.id;
          _arrivedTimestamp = ticket.arrivedTimesTimep;
          AccountPrefs.statusTicket = 'arrived';
          update();
          steperCompleted(2);
          Get.snackbar('success', 'Photo upload successfully.',
              colorText: Colors.black,
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket arrived time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnArrrived.reset();
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'The ticket cannot be uploaded internally.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _btnArrrived.reset();
    }
  }

  //
  //Update FinishedTime
  updateFinishedTimeTicket() async {
    try {
      final String urlApi = '${api.api}/${api.updateFinishedInTicket}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'id': _currentTicket?.id,
        'shift_id': AccountPrefs.currentShift,
        'description': descriptionControlText.text,
        'finished_photo': _finishedPhoto,
        'work_hours': _workHours,
        'supervisor_id': _supervisorID,
        'supervisor_work_hours': _supervisorWorkHours,
        'additional_equipment_ids': _additionalEquipmentIDs
      };

      if (_finishedPhoto == '') {
        Get.snackbar('Warning', 'Please upload a picture to finished ticket.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4));
        _btnfinished.reset();
        return false;
      }

      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      var decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        // if (decodeResp['data'].length > 0) {
        //late List dataObject = decodeResp['data'] as List;

        TicketModel ticket = TicketModel.fromJson(decodeResp['data']);
        // print(' ticket finishedTime: ${ticket.finishedTimesTimep}');
        // AccountPrefs.hasOpenTicke = ticket.id;
        _finishedTimestamp = ticket.finishedTimesTimep;
        _ticketId = ticket.id;
        counterFails = 0;
        //'inactive_ticket', 'accepted', 'departed', 'arrived', 'finished'
        AccountPrefs.statusTicket = 'finished';
        AccountPrefs.hasOpenTicke = 0;
        update();
        steperCompleted(2);
        Get.snackbar('success', 'Photo upload successfully.',
            colorText: Colors.black,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
        // }
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnfinished.reset();
      }
    } catch (e) {
      print(e.toString());
      counterFails++;
      if (counterFails < 3) {
        await updateFinishedTimeTicket();
      } else {
        await updateFinishedTimeTicketNotWifi();
        counterFails = 0;
        update();
      }
      // _btnfinished.reset();
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save finished Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  updateFinishedTimeTicketNotWifi() async {
    try {
      if (_finishedPhoto == '') {
        Get.snackbar('Warning', 'Please upload a picture to finished ticket.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4));
        _btnfinished.reset();
        return false;
      }
      int ticketSend =
          _currentTicket!.id != 0 ? _currentTicket!.id : _currentTicket!.idKey;
      final response = await TicketsSQL().updateFinishedTicketSQL(
          ticketSend, _finishedPhoto, descriptionControlText.text);

      //var decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          TicketModel ticket = response['data'];
          _finishedTimestamp = ticket.finishedTimesTimep;
          _ticketId = ticket.id;
          AccountPrefs.hasOpenTicke = 0;
          AccountPrefs.statusTicket = 'finished';
          update();
          steperCompleted(2);
          Get.snackbar('success', 'Photo upload successfully.',
              colorText: Colors.black,
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnfinished.reset();
      }
    } catch (e) {
      print(e.toString());
      _btnfinished.reset();
      Get.snackbar('Error',
          'There was a problem connecting to the server.To save finished Time',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  endTicket() async {
    if (AccountPrefs.statusConnection == false) {
      final response =
          await TicketsSQL().getActiveTicketSQL(AccountPrefs.hasOpenTicke);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          TicketModel ticket = response['data'];
          await TicketsSQL().insertTicketsFinishedSQL(ticket);
        }
      }
    }

    // AccountPrefs.hasOpenTicke = 0;
    AccountPrefs.statusTicket = 'inactive_ticket';
    update();
    Get.offNamed('/newTicket');
    //move to createNew ticket
    // Get.off(
    //   () => CreateTicketForm(
    //       //controller: Get.find<HomeController>(),
    //       ),
    //   transition: Transition.leftToRight,
    //   duration: const Duration(milliseconds: 250),
    // );
  }

  endShift() async {
    /*Get.to(
      () => PagesScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );*/
    //update();
    try {
      final String urlApi =
          '${api.api}/${api.endShift}${AccountPrefs.currentShift}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'flag': true, //with conetion
        'active': 0,
      };
      //print(body);
      final response = await http.put(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print('FinishedTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        update();
        Get.offNamed('/pages');
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnEndShift.reset();
      }
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await endShift();
      } else {
        await endShiftNOtWifi();
        counterFails = 0;
        update();
      }
      // print(e.toString());
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save finished Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
      // _btnEndShift.reset();
    }
  }
  //

  endShiftNOtWifi() async {
    try {
      final response =
          await ShiftSQL().finishShiftSQL(AccountPrefs.currentShift);

      // Map<String, dynamic> decodeResp = json.decode(response.body);
      // print('FinishedTime = $decodeResp');
      if (response['statusCode'] == 200 && response['success'] == true) {
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        update();
        Get.offNamed('/pages');
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        _btnEndShift.reset();
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server.To save finished Time',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      _btnEndShift.reset();
    }
  }

  getSupervisors() async {
    try {
      //loading dialog
      final String urlApi = '${api.api}/${api.supervisors}'; //url/api/login
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
          _supervisorList = (decodeResp['data'] as List)
              .map((e) => SupervisorModel.fromJson(e))
              .toList();
        } else {
          _supervisorList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _supervisorList = [];
      }
      update();
      return _supervisorList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _supervisorList = [];
    }
  }

  getAdditionalEquipment() async {
    try {
      //loading dialog
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
          _additionalEquipmentList = (decodeResp['data'] as List)
              .map((e) => EquipmentModel.fromJson(e))
              .toList();
        } else {
          _additionalEquipmentList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        _additionalEquipmentList = [];
      }
      update();
      return _additionalEquipmentList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return _additionalEquipmentList = [];
    }
  }

  downloadDataToApp() async {
    await TicketDescriptionSQL().trucateTicketDescription();
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
  //END FUNC
}
