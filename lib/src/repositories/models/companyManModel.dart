class CompanyManModel {
  final int id;
  final int customerId;
  final String name;

  CompanyManModel({
    required this.id,
    required this.customerId,
    required this.name,
  });

  factory CompanyManModel.fromJson(Map<String, dynamic> json) => CompanyManModel(
        id: int.parse(json['id'].toString()),
        customerId: int.parse(json['customer_id'].toString()),
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "name": name,
      };
}
