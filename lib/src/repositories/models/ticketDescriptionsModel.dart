class TicketDescriptionsModel {
  final int id;
  final String name;
  final String spanishName;
  final String descrition;

  TicketDescriptionsModel({
    required this.id,
    required this.name,
    required this.descrition,
    required this.spanishName,
  });

  factory TicketDescriptionsModel.fromJson(Map<String, dynamic> json) =>
      TicketDescriptionsModel(
        id: int.parse(json['id'].toString()),
        name: json['name'] ?? '',
        spanishName: json['name_spanish'] ?? '',
        descrition: json['text'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "spanishName": spanishName,
        "descrition": descrition,
      };
}
