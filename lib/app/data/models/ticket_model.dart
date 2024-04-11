import 'dart:convert';
import 'dart:developer';

import 'package:onax_app/app/data/models/project_model.dart';

class Ticket {
  int? id;
  String? prefix;
  int? companyId;
  int? shiftId;
  int? companyManId;
  String? customer;
  int? customerId;
  int? destinationId;
  int? projectId;
  String? date;
  int? equipmentId;
  int? workerId;
  int? helperId;
  int? helper2Id;
  int? helper3Id;
  String? departTimestamp;
  String? arrivedTimestamp;
  String? finishedTimestamp;
  dynamic workHours;
  String? arrivedPhoto;
  String? finishedPhoto;
  String? description;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic invoiceId;
  dynamic signature;
  int? supervisorId;
  dynamic supervisorWorkHours;
  dynamic additionalEquipmentId;
  int? workerTypeId;
  dynamic firstInspection;
  dynamic finalInspection;
  String? dateFormatted;
  Project? project;
  List<Map<String, dynamic>>? aditionalWorkers;
  Ticket(
      {this.id,
      this.prefix,
      this.companyId,
      this.shiftId,
      this.companyManId,
      this.customer,
      this.customerId,
      this.destinationId,
      this.projectId,
      this.date,
      this.equipmentId,
      this.workerId,
      this.helperId,
      this.helper2Id,
      this.helper3Id,
      this.departTimestamp,
      this.arrivedTimestamp,
      this.finishedTimestamp,
      this.workHours,
      this.arrivedPhoto,
      this.finishedPhoto,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.invoiceId,
      this.signature,
      this.supervisorId,
      this.supervisorWorkHours,
      this.additionalEquipmentId,
      this.workerTypeId,
      this.firstInspection,
      this.finalInspection,
      this.dateFormatted,
      this.project,
      this.aditionalWorkers});

  Ticket.nullTicket({
    id = null,
    prefix = null,
    companyId = null,
    shiftId = null,
    companyManId = null,
    customer = null,
    customerId = null,
    destinationId = null,
    projectId = null,
    date = null,
    equipmentId = null,
    workerId = null,
    helperId = null,
    helper2Id = null,
    helper3Id = null,
    departTimestamp = null,
    arrivedTimestamp = null,
    finishedTimestamp = null,
    workHours = null,
    arrivedPhoto = null,
    finishedPhoto = null,
    description = null,
    createdAt = null,
    updatedAt = null,
    deletedAt = null,
    invoiceId = null,
    signature = null,
    supervisorId = null,
    supervisorWorkHours = null,
    additionalEquipmentId = null,
    workerTypeId = null,
    firstInspection = null,
    finalInspection = null,
    dateFormatted = null,
    project = null,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefix = json['prefix'];
    companyId = json['company_id'];
    shiftId = json['shift_id'];
    companyManId = json['company_man_id'];
    customer = json['customer'];
    customerId = json['customer_id'];
    destinationId = json['destination_id'];
    projectId = json['project_id'];
    date = json['date'];
    equipmentId = json['equipment_id'];
    workerId = json['worker_id'];
    helperId = json['helper_id'];
    helper2Id = json['helper2_id'];
    helper3Id = json['helper3_id'];
    departTimestamp = json['depart_timestamp'];
    arrivedTimestamp = json['arrived_timestamp'];
    finishedTimestamp = json['finished_timestamp'];
    workHours = json['work_hours'];
    arrivedPhoto = json['arrived_photo'];
    finishedPhoto = json['finished_photo'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    invoiceId = json['invoice_id'];
    signature = json['signature'];
    supervisorId = json['supervisor_id'];
    supervisorWorkHours = json['supervisor_work_hours'];
    additionalEquipmentId = json['additional_equipment_id'];
    workerTypeId = json['worker_type_id'];
    firstInspection = json['first_inspection'];
    finalInspection = json['final_inspection'];
    dateFormatted = json['date_formatted'];
    project = null;
    aditionalWorkers = (json['workers'] != null)
        ? aditionalWorkers = List<Map<String, dynamic>>.from(
            json['workers'].map((x) => Map<String, dynamic>.from(x)),
          )
        : [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['prefix'] = prefix;
    data['company_id'] = companyId;
    data['shift_id'] = shiftId;
    data['company_man_id'] = companyManId;
    data['customer'] = customer;
    data['customer_id'] = customerId;
    data['destination_id'] = destinationId;
    data['project_id'] = projectId;
    data['date'] = date;
    data['equipment_id'] = equipmentId;
    data['worker_id'] = workerId;
    data['helper_id'] = helperId;
    data['helper2_id'] = helper2Id;
    data['helper3_id'] = helper3Id;
    data['depart_timestamp'] = departTimestamp;
    data['arrived_timestamp'] = arrivedTimestamp;
    data['finished_timestamp'] = finishedTimestamp;
    data['work_hours'] = workHours;
    data['arrived_photo'] = arrivedPhoto;
    data['finished_photo'] = finishedPhoto;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['invoice_id'] = invoiceId;
    data['signature'] = signature;
    data['supervisor_id'] = supervisorId;
    data['supervisor_work_hours'] = supervisorWorkHours;
    data['additional_equipment_id'] = additionalEquipmentId;
    data['worker_type_id'] = workerTypeId;
    data['first_inspection'] = firstInspection;
    data['final_inspection'] = finalInspection;
    data['date_formatted'] = dateFormatted;
    data['project'] = project;
    data['workers'] = aditionalWorkers;
    return data;
  }

  static Map<String, dynamic> toLocalDataBaseJson(Map<String, dynamic> data) {
    final newData = <String, dynamic>{};
    newData['id'] = data['id'] ?? 0;
    newData['prefix'] = data['prefix'] ?? "Offline";
    newData['company_id'] = data['company_id'];
    newData['shift_id'] = data['shift_id'];
    newData['company_man_id'] = data['company_man_id'];
    newData['customer'] = data['customer'];
    newData['customer_id'] = data['customer_id'];
    newData['destination_id'] = data['destination_id'];
    newData['project_id'] = data['project_id'];
    newData['date'] = data['date'];
    newData['equipment_id'] = data['equipment_id'];
    newData['worker_id'] = data['worker_id'];
    newData['helper_id'] = data['helper_id'];
    newData['helper2_id'] = data['helper2_id'];
    newData['helper3_id'] = data['helper3_id'];
    newData['depart_timestamp'] = data['depart_timestamp'];
    newData['arrived_timestamp'] = data['arrived_timestamp'];
    newData['finished_timestamp'] = data['finished_timestamp'];
    newData['work_hours'] = data['work_hours'];
    newData['arrived_photo'] = data['arrived_photo'];
    newData['finished_photo'] = data['finished_photo'];
    newData['description'] = data['description'];
    newData['created_at'] =
        data['created_at'] ?? DateTime.now().toIso8601String();
    newData['updated_at'] = data['updated_at'];
    newData['deleted_at'] = data['deleted_at'];
    newData['invoice_id'] = data['invoice_id'];
    newData['signature'] = data['signature'];
    newData['supervisor_id'] = data['supervisor_id'];
    newData['supervisor_work_hours'] = data['supervisor_work_hours'];
    newData['additional_equipment_id'] = data['additional_equipment_id'];
    newData['worker_type_id'] = data['worker_type_id'];
    newData['first_inspection'] = data['first_inspection'];
    newData['final_inspection'] = data['final_inspection'];
    newData['date_formatted'] = data['date_formatted'];
    newData['workers'] = jsonEncode(data['workers']);
    return newData;
  }

  static Map<String, dynamic> fromLocalDataBaseJson(Map<String, dynamic> data) {
    final newData = <String, dynamic>{};
    newData['id'] = data['id'];
    newData['prefix'] = data['prefix'];
    newData['company_id'] = data['company_id'];
    newData['shift_id'] = data['shift_id'];
    newData['company_man_id'] = data['company_man_id'];
    newData['customer'] = data['customer'];
    newData['customer_id'] = data['customer_id'];
    newData['destination_id'] = data['destination_id'];
    newData['project_id'] = data['project_id'];
    newData['date'] = data['date'];
    newData['equipment_id'] = data['equipment_id'];
    newData['worker_id'] = data['worker_id'];
    newData['helper_id'] = data['helper_id'];
    newData['helper2_id'] = data['helper2_id'];
    newData['helper3_id'] = data['helper3_id'];
    newData['depart_timestamp'] = data['depart_timestamp'];
    newData['arrived_timestamp'] = data['arrived_timestamp'];
    newData['finished_timestamp'] = data['finished_timestamp'];
    newData['work_hours'] = data['work_hours'];
    newData['arrived_photo'] = data['arrived_photo'];
    newData['finished_photo'] = data['finished_photo'];
    newData['description'] = data['description'];
    newData['created_at'] = data['created_at'];
    newData['updated_at'] = data['updated_at'];
    newData['deleted_at'] = data['deleted_at'];
    newData['invoice_id'] = data['invoice_id'];
    newData['signature'] = data['signature'];
    newData['supervisor_id'] = data['supervisor_id'];
    newData['supervisor_work_hours'] = data['supervisor_work_hours'];
    newData['additional_equipment_id'] = data['additional_equipment_id'];
    newData['worker_type_id'] = data['worker_type_id'];
    newData['first_inspection'] = data['first_inspection'];
    newData['final_inspection'] = data['final_inspection'];
    newData['date_formatted'] = data['date_formatted'];
    newData['workers'] = jsonDecode(data['workers']);
    return newData;
  }

  getStatus() {
    String state;

    if (true == true) {
      state = "Spring";
    } else if (true == true) {
      state = "Summer";
    } else if (true == true) {
      state = "Autumn";
    } else if (true == true) {
      state = "Winter";
    } else {
      state = "Invalid";
    }

    return state;
  }
}
