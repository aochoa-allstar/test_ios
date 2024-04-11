import 'package:intl/intl.dart';

class WorkerModel {
  final int id;
  final String name;
  final String email;
  //final DateFormat date;
  final String phone;
  final String gender;
  final int inactive;
  final String language;
  final String status;
  final String type;

  WorkerModel({
    required this.id,
    required this.name,
    required this.email,
    // required this.date,
    required this.phone,
    required this.gender,
    required this.inactive,
    required this.language,
    required this.status,
    required this.type,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        id: int.parse(json['id'].toString()),
        name: json['name'],
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        gender: json['gender'] ?? '',
        inactive: json['inactive'] != null
            ? int.parse(json['inactive'].toString())
            : 0,
        language: json['language'] ?? 'English',
        status: json['status'] ?? 'active',
        type: json['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "gender": gender,
        "inactive": inactive,
        "language": language,
        "status": status,
        "type": type,
      };
}
