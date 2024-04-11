class CompanyMan {
  dynamic id;
  dynamic companyId;
  dynamic customerId;
  dynamic name;
  dynamic phone;
  dynamic email;
  dynamic password;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  CompanyMan(
      {this.id,
      this.companyId,
      this.customerId,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CompanyMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    customerId = json['customer_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
