class WokerTypeModel {
  final int id;

  final String name;

  WokerTypeModel({
    required this.id,
    required this.name,
  });

  factory WokerTypeModel.fromJson(Map<String, dynamic> json) => WokerTypeModel(
        id: int.parse(json['id'].toString()),
        name: json['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
