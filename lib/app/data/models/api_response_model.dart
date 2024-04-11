class ApiResponse {
  bool? success;
  dynamic data;
  String? message;

  ApiResponse({this.success, this.data, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}
