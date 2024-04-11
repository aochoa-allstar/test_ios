class Shift {
  dynamic id;
  dynamic workerId;
  dynamic startTime;
  dynamic endTime;
  dynamic equipmentId;
  dynamic helperId;
  dynamic helper2Id;
  dynamic helper3Id;
  dynamic active;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic temId;
  dynamic workerTypeId;

  Shift(
      {this.id,
      this.workerId,
      this.startTime,
      this.endTime,
      this.equipmentId,
      this.helperId,
      this.helper2Id,
      this.helper3Id,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.temId,
      this.workerTypeId});

  Shift.nullShift() {
    id = null;
    workerId = null;
    workerTypeId = null;
    startTime = null;
    endTime = null;
    equipmentId = null;
    helperId = null;
    helper2Id = null;
    helper3Id = null;
    active = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = DateTime.now().toIso8601String();
    temId = null;
  }

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workerId = json['worker_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    equipmentId = json['equipment_id'];
    helperId = json['helper_id'];
    helper2Id = json['helper2_id'];
    helper3Id = json['helper3_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    temId = json['temId'];
    workerTypeId = json['worker_type_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['worker_id'] = workerId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['equipment_id'] = equipmentId;
    data['helper_id'] = helperId;
    data['helper2_id'] = helper2Id;
    data['helper3_id'] = helper3Id;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['temId'] = temId;
    data['worker_type_id'] = workerTypeId;
    return data;
  }

  Map<String, dynamic> toLocalDatabaseJson() {
    final data = <String, dynamic>{};
    data['id'] = 0;
    data['worker_id'] = workerId;
    data['start_time'] = DateTime.now().toIso8601String();
    data['end_time'] = endTime;
    data['equipment_id'] = equipmentId;
    data['helper_id'] = helperId;
    data['helper2_id'] = helper2Id;
    data['helper3_id'] = helper3Id;
    data['active'] = true;
    data['created_at'] = DateTime.now().toIso8601String();
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['temId'] = temId;
    data['worker_type_id'] = workerTypeId;
    return data;
  }
}
