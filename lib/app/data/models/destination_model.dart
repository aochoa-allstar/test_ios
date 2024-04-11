class Destination {
  dynamic id;
  dynamic companyId;
  dynamic name;
  dynamic coords;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Destination(
      {this.id,
      this.companyId,
      this.name,
      this.coords,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    coords = json['coords'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['coords'] = coords;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
