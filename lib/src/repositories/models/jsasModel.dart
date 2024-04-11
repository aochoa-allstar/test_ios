class JsasModel {
  final int id;
  final String projectName;
  final String date;
  final int? ticketId;

  JsasModel({
    required this.id,
    required this.projectName,
    required this.date,
    this.ticketId,
  });

  factory JsasModel.fromJson(Map<String, dynamic> json) => JsasModel(
        id: int.parse(json['id'].toString()),
        projectName:
            json['projects'] != null ? json['projects']['name'] : 'No Project',

        date: json['date'].toString(), //DateTime.parse(),
        ticketId: json['ticket_id'] != null ? json['ticket_id'] : null
        // ticketId: 160
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectName": projectName,
        "date": date,
        "ticketId": ticketId,
      };
}
