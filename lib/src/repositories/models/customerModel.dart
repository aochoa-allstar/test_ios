class CustomerModel {
  final int id;

  final String name;

  CustomerModel({
    required this.id,
    required this.name,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: int.parse(json['id'].toString()),
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
