class WorkerType {
  dynamic id;
  dynamic type;
  dynamic helpersQuantity;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  WorkerType(
      {this.id,
      this.type,
      this.helpersQuantity,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  WorkerType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    helpersQuantity = json['helpers_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['helpers_quantity'] = helpersQuantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
