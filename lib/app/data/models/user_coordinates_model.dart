class UserCoordinates {
  final double? latitude;
  final double? longitude;

  UserCoordinates({required this.latitude, required this.longitude});

  factory UserCoordinates.fromJson(Map<String, dynamic> json) {
    return UserCoordinates(
        latitude: json['latitude'], longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
