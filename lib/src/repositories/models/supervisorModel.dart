class SupervisorModel {
  final int id;
  final String name;

  SupervisorModel({
    required this.id,
    required this.name,
  });

  factory SupervisorModel.fromJson(Map<String, dynamic> json) => SupervisorModel(
        id: int.parse(json['id'].toString()),
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
