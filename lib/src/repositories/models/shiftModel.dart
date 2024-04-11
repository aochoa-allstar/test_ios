// ignore_for_file: prefer_if_null_operators

import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

class ShiftModel {
  final int idKey;
  final int id;
  final int workerId;
  final int equipmentId;
  final String startTime;
  late String endTime;
  final int helper;
  final int helper2;
  final int helper3;
  final int active;
  final String temId;
  final int worker_type_id;

  ShiftModel({
    required this.idKey,
    required this.id,
    required this.workerId,
    required this.equipmentId,
    required this.startTime,
    required this.endTime,
    required this.helper,
    required this.helper2,
    required this.helper3,
    required this.active,
    required this.temId,
    required this.worker_type_id,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
        idKey: json['idKey'] != null
            ? int.parse(json['idKey'].toString())
            : AccountPrefs.currentShift,
        id: int.parse(json['id'].toString()),
        workerId: int.parse(json['worker_id'].toString()),
        equipmentId: json['equipment_id'] != null || json['equipment_id'] > 0
            ? int.parse(json['equipment_id'].toString())
            : 0,
        startTime: //DateTime.parse(json['start_time'].toString()),
            json['start_time'] != null
                ? json['start_time']
                    .toString() //DateTime.parse(json['start_time'].toString())
                : '',
        endTime: json['end_time'] != null
            ? json['end_time']
                .toString() //DateTime.parse(json['end_time'].toString())
            : '',
        helper: json['helper_id'] != null || json['helper_id'] > 0
            ? int.parse(json['helper_id'].toString())
            : 0,
        helper2: json['helper2_id'] != null || json['helper2_id'] > 0
            ? int.parse(json['helper2_id'].toString())
            : 0,
        helper3: json['helper3_id'] != null || json['helper3_id'] > 0
            ? int.parse(json['helper3_id'].toString())
            : 0,
        active:
            json['active'] != null ? int.parse(json['active'].toString()) : 0,
        temId: json['temId'],
        worker_type_id: json['worker_type_id'] != null
            ? int.parse(json['worker_type_id'].toString())
            : 0,
        // != null
        //     ? json['temId']
        //     : json['idKey'] != null
        //         ? 't-${json['idKey']}'
        //         : 't-${AccountPrefs.currentShift}',
      );

  Map<String, dynamic> toJson() => {
        "idKey": idKey,
        "id": id,
        "workerId": workerId,
        "equipmentId": equipmentId,
        "startTime": startTime,
        "endTime": endTime,
        "helper": helper,
        "helper2": helper2,
        "helper3": helper3,
        "active": active,
        "temId": temId,
        "worker_type_id": worker_type_id,
      };
}
