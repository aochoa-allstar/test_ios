// ignore_for_file: file_names

class DestinyOriginModel {
  final int id;
  final String name;
  final String cords;

  DestinyOriginModel(
      {required this.id, required this.name, required this.cords});

  factory DestinyOriginModel.fromJson(Map<String, dynamic> json) =>
      DestinyOriginModel(
        id: int.parse(json['id'].toString()),
        cords: json['coords'] != null ? json['coords'] : '',
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cords": cords,
      };
}
