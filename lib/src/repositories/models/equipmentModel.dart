// ignore_for_file: file_names

class EquipmentModel {
  final int id;
  final int? workerId;
  final String name;
  final String? plate;
  final String vin;
  final String make;
  final String model;
  final String? year;
  final int inactive;
  final String type;

  EquipmentModel({
    required this.id,
    this.workerId,
    required this.name,
    this.plate,
    required this.vin,
    required this.make,
    required this.model,
    this.year,
    required this.inactive,
    required this.type,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
      id: int.parse(json['id'].toString()),
      // workerId: int.parse(json['worker_id'].toString()),
      workerId: json['worker_id'] != null
          ? int.parse(json['worker_id'].toString())
          : null,
      name: json['number'],
      plate: json['plate'] != null ? json['plate'] : "",
      vin: json['vin'] != null ? json['vin'] : "",
      make: json['make'] != null ? json['make'] : "",
      model: json['model'] != null ? json['model'] : "",
      year: json['year'] != null ? json['year'] : "",
      inactive: int.parse(json['inactive'].toString()),
      type: json['type'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "workerId": workerId,
        "name": name,
        "make": make,
        "vin": vin,
        "plate": plate,
        "model": model,
        "year": year,
        "inactive": inactive,
        "type": type,
      };
}
