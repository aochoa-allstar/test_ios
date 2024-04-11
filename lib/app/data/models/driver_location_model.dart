class DriverLocationModel {
  dynamic id;
  dynamic workerId, ticketId;
  dynamic speed;
  dynamic latitude; 
  dynamic longitude;
  dynamic status;
  dynamic initDate;
  dynamic endDate;

  DriverLocationModel({
    this.speed,
    this.id,
    this.workerId,
    this.ticketId,
    this.latitude,
    this.longitude,
    this.status,
    this.initDate,
    this.endDate,
  });

  DriverLocationModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      ticketId = json['ticket_id'];
      workerId = json['worker_id'];
      latitude = json['latitude'];
      longitude = json['longitude'];
      status = json['status'];
      initDate = json['init_date'];
      endDate = json['end_date'];
      speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['id'] = id;
    data['ticket_id'] = ticketId;
    data['worker_id'] = workerId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['init_date'] = initDate;
    data['end_date'] = endDate;
    data['speed'] = speed;
    return data;
  }
}
