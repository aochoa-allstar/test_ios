class Equipment {
  dynamic id;
  dynamic companyId;
  dynamic workerId;
  dynamic equipmentTypeId;
  dynamic number;
  dynamic plate;
  dynamic vin;
  dynamic make;
  dynamic model;
  dynamic year;
  dynamic inactive;
  dynamic rateType;
  dynamic rate;
  dynamic type;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Equipment(
      {this.id,
      this.companyId,
      this.workerId,
      this.equipmentTypeId,
      this.number,
      this.plate,
      this.vin,
      this.make,
      this.model,
      this.year,
      this.inactive,
      this.rateType,
      this.rate,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Equipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    workerId = json['worker_id'];
    equipmentTypeId = json['equipment_type_id'];
    number = json['number'];
    plate = json['plate'];
    vin = json['vin'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    inactive = json['inactive'];
    rateType = json['rate_type'];
    rate = json['rate'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['worker_id'] = workerId;
    data['equipment_type_id'] = equipmentTypeId;
    data['number'] = number;
    data['plate'] = plate;
    data['vin'] = vin;
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['inactive'] = inactive;
    data['rate_type'] = rateType;
    data['rate'] = rate;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
