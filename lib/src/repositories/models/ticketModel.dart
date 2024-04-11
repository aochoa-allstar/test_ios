class TicketModel {
  final int idKey;
  final int id;
  final int workerId;
  final int equipmentId;
  final int shiftId;
  final String customer;
  final int customerId;
  final int destinationId;
  final int projectId;
  final String date;
  final int helperId;
  final int helperId2;
  final int helperId3;
  final String deparmentTimesTimep;
  final String arrivedTimesTimep;
  final String finishedTimesTimep;
  final String arrivedPhoto;
  final String finishedPhoto;
  final String descrition;
  final String signature;
  final int work_hours;
  final String prefix;
  final int worker_type_id;

  TicketModel(
      {required this.idKey,
      required this.id,
      required this.workerId,
      required this.equipmentId,
      required this.shiftId,
      required this.customer,
      required this.customerId,
      required this.destinationId,
      required this.projectId,
      required this.date,
      required this.helperId,
      required this.helperId2,
      required this.helperId3,
      required this.deparmentTimesTimep,
      required this.arrivedTimesTimep,
      required this.finishedTimesTimep,
      required this.arrivedPhoto,
      required this.finishedPhoto,
      required this.descrition,
      required this.signature,
      required this.work_hours,
      required this.worker_type_id,
      this.prefix = ''});

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
      idKey: json['idKey'] != null ? int.parse(json['idKey'].toString()) : 0,
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      shiftId: int.parse(json['shift_id'].toString()),
      customer: json['customer'] ?? '',
      customerId: int.parse(json['customer_id'].toString()),
      destinationId: json['destination_id'] != null
          ? int.parse(json['destination_id'].toString())
          : 0,
      projectId: json['project_id'] != null
          ? int.parse(json['project_id'].toString())
          : 0,
      date: json['date'].toString(), //DateTime.parse(json['date'].toString()),
      equipmentId: json['equipment_id'] != null
          ? int.parse(json['equipment_id'].toString())
          : 0,
      workerId: int.parse(json['worker_id'].toString()),
      helperId: json['helper_id'] != null
          ? int.parse(json['helper_id'].toString())
          : 0,
      helperId2: json['helper_id2'] != null
          ? int.parse(json['helper2_id'].toString())
          : 0,
      helperId3: json['helper_id3'] != null
          ? int.parse(json['helper3_id'].toString())
          : 0,
      deparmentTimesTimep: json['depart_timestamp'] != null
          ? json['depart_timestamp'].toString()
          : '',
      arrivedTimesTimep: json['arrived_timestamp'] != null
          ? json['arrived_timestamp'].toString()
          : '',
      finishedTimesTimep: json['finished_timestamp'] != null
          ? json['finished_timestamp'].toString()
          : '',
      arrivedPhoto: json['arrived_photo'] ?? '',
      finishedPhoto: json['finished_photo'] ?? '',
      descrition: json['description'] ?? '',
      signature: json['signature'] ?? '',
      work_hours: json['work_hours'] != null ? json['work_hours'] : 0,
      worker_type_id: json['worker_type_id'] != null
          ? int.parse(json['worker_type_id'].toString())
          : 0,
      prefix: json['prefix'] ?? '');
}
