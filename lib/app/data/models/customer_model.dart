class Customer {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic invoiceEmail;
  dynamic phone;
  dynamic paymentDays;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.invoiceEmail,
      this.phone,
      this.paymentDays,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pivot});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    invoiceEmail = json['invoice_email'];
    phone = json['phone'];
    paymentDays = json['payment_days'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pivot = json['pivot'] != null ? Pivot?.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['invoice_email'] = invoiceEmail;
    data['phone'] = phone;
    data['payment_days'] = paymentDays;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (pivot != null) {
      data['pivot'] = pivot?.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic companyId;
  dynamic customerId;
  dynamic createdAt;
  dynamic updatedAt;

  Pivot({this.companyId, this.customerId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
