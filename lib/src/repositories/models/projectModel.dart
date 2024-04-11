class ProjectModel {
  final int id;
  final int customerId;
  final String name;
  final String initialDate;

  ProjectModel({
    required this.id,
    required this.customerId,
    required this.name,
    required this.initialDate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: int.parse(json['id'].toString()),
        customerId: int.parse(json['customer_id'].toString()),
        name: json['name'] ?? '',
        initialDate: json['initial_date'].toString(), //DateTime.parse(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "name": name,
        "initialDate": initialDate,
      };
}
