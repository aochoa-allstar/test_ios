import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/server/base_server_provider.dart';
import 'package:onax_app/app/routes/api_routes.dart';

class TicketsServerProvider extends BaseServerProvider {
  Future<Response> createTicket(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.TICKET,
      body,
      headers: {'notify-on-success': 'true'},
    );
  }

  Future<Response> getTicketHistory() async {
    return await get(ApiRoutes.TICKET, query: {"status": "finished"});
  }

  Future<Response> getAllTickets() async {
    return await get(ApiRoutes.TICKET);
  }

  Future<Response> getActiveTicket() async {
    return await get(ApiRoutes.ACTIVE_TICKET);
  }

  Future<Response> updateTicketDepart(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.UPDATE_TICKET_DEPART,
      body,
    );
  }

  Future<Response> signTicket(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.SIGN_TICKET,
      body,
    );
  }

  Future<Response> updateTicketArrive(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.UPDATE_TICKET_ARRIVE,
      body,
    );
  }

  Future<Response> updateTicketFinish(Map<String, dynamic> body) async {
    return await post(
      ApiRoutes.UPDATE_TICKET_FINISH,
      body,
    );
  }
}
