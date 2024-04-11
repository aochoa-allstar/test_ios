class LocationModel {
  final int id;
  final int workerId, ticketId;
  final double speed;
  final String latitude, longitude, status, initDate, endDate;

  LocationModel({
    required this.speed,
    required this.id,
    required this.workerId,
    required this.ticketId,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.initDate,
    required this.endDate,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      ticketId: json['ticket_id'] ?? 0,
      workerId: int.parse(json['worker_id'].toString()),
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      status: json['status'] ?? '',
      initDate: json['init_date'] ?? '',
      endDate: json['end_date'] ?? '',
      speed: json['speed'] ?? 0.0);
}
