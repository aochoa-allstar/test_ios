import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/data/providers/local/tickets_local_provider.dart';
import 'package:onax_app/app/data/providers/server/tickets_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:http/http.dart' as http;
import 'package:onax_app/core/services/sqlite_service.dart';

class TicketsRepository extends GetxController {
  TicketsRepository(
      {required this.serverProvider, required this.localProvider});

  final TicketsServerProvider serverProvider;
  final TicketsLocalProvider localProvider;

  NetworkService networkService = Get.find();
  PreferencesService preferences = Get.find();
  PreferencesService preferencesService = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  dynamic decoder(data) {
    //Ticket was not found?
    //TODO: Improve this error handling when the Ticket was not found.
    if (data is Map<String, dynamic>) return Ticket.fromJson(data);
    if (data is List) return data.map((item) => Ticket.fromJson(item)).toList();
  }

  ApiResponse decodeResponse(Response httpResponse) {
    try {
      //TODO: Check why when we finish a ticket the response is null
      ApiResponse apiResponse = httpResponse.body;
      apiResponse.data = decoder(apiResponse.data);
      return apiResponse;
    } catch (e) {
      log('Error decoding ticket response: $e');
      return ApiResponse(
        success: false,
        message: 'Error decoding response',
        data: null,
      );
    }
  }

  Future<ApiResponse> createTicket(
    int workerId,
    int shiftId,
    int customerId,
    int projectId,
    int companyManId,
    int equipmentId,
    int? helper1Id,
    int? helper2Id,
    int? helper3Id,
    int? workerTypeId,
    List<Map<String, dynamic>> additionalEquipmentIDs,
    int? supervisorId,
  ) async {
    final body = {
      'worker_id': workerId,
      'shift_id': shiftId,
      'customer_id': customerId,
      'project_id': projectId,
      'company_man_id': companyManId,
      'equipment_id': equipmentId,
      'helper_id': helper1Id,
      'helper2_id': helper2Id,
      'helper3_id': helper3Id,
      'worker_type_id': workerTypeId,
      "workers": additionalEquipmentIDs,
      "supervisor_id": supervisorId
    };
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.createTicket(body)
            : await serverProvider.createTicket(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getTicketHistory() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getTicketHistory();
    } else {
      httpResponse = await serverProvider.getTicketHistory();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateFinishedTicketsTable(serverResponse.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getAllTickets() async {
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.getTicketHistory()
            : await serverProvider.getAllTickets();

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> getActiveTicket() async {
    Response httpResponse;
    if (networkService.connectionType.value == ConnectivityResult.none) {
      httpResponse = await localProvider.getActiveTicket();
    } else {
      httpResponse = await serverProvider.getActiveTicket();
      ApiResponse serverResponse = httpResponse.body;
      if (serverResponse.success != null && serverResponse.success!) {
        localProvider.populateCurrentTicketTable(httpResponse.body.data);
      }
    }

    return decodeResponse(httpResponse);
  }

  //TODO: Correct this implementation
  Future<String?> getTicketDetailsHtml(int ticketId) async {
    final Session session = await preferencesService.getSession();
    final token = session.sessionToken;
    final response = await http.get(
        Uri.parse(
            '${ApiRoutes.BASE + ApiRoutes.VIEW_TICKET_PDF}/${ticketId}/1'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token}',
        });
    if (response.statusCode == 200) {
      final String htmlContent = response.body;
      return htmlContent;
    } else {
      return null;
    }
  }

  Future<ApiResponse> updateTicketDepart(
    int ticketId,
    int shiftId,
  ) async {
    final body = {
      'id': ticketId,
      'shift_id': shiftId,
    };

    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.updateTicketDepart(body)
            : await serverProvider.updateTicketDepart(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> updateTicketArrive(
    int ticketId,
    int shiftId,
    String arrivedPhoto,
  ) async {
    final body = {
      'id': ticketId,
      'shift_id': shiftId,
      'arrived_photo': arrivedPhoto,
    };

    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.updateTicketArrive(body)
            : await serverProvider.updateTicketArrive(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> updateTicketFinish(
    int ticketId,
    int shiftId,
    String finishedPhoto,
    String description,
    int supervisorId,
    int supervisorWorkHours,
    dynamic additionalEquipmentIDs,
    List<Map<String, dynamic>> aditionalWorkers,
    List<dynamic> materials,
  ) async {
    Map<String, dynamic> body = {
      "id": ticketId,
      "shift_id": shiftId,
      "finished_photo": finishedPhoto,
      "description": description,
      "supervisor_id": supervisorId,
      "supervisor_work_hours": supervisorWorkHours,
      "additional_equipment_ids": additionalEquipmentIDs,
      "workers": aditionalWorkers,
      "materials": materials
    };
    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.updateTicketFinish(body)
            : await serverProvider.updateTicketFinish(body);

    return decodeResponse(httpResponse);
  }

  Future<ApiResponse> signTicket(
    int ticketId,
    String signatureBase64,
  ) async {
    Map<String, dynamic> body = {"id": ticketId, "signature": signatureBase64};

    Response httpResponse =
        networkService.connectionType.value == ConnectivityResult.none
            ? await localProvider.signTicket()
            : await serverProvider.signTicket(body);

    return decodeResponse(httpResponse);
  }
}
