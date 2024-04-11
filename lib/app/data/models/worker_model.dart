class UserWorker {
  int? id;
  int? companyId;
  String? name;
  String? email;
  String? password;
  String? passwordToken;
  String? birthdate;
  String? phone;
  String? address;
  String? gender;
  String? language;
  String? status;
  int? workerTypeId;
  int? whoEditedIt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic signature;
  dynamic completedPaperwork;
  dynamic inactive;
  dynamic inactiveObservations;
  String? customerRate;
  String? workerRate;
  String? type;
  int? helpersQuantity;

  UserWorker({
    this.id,
    this.companyId,
    this.name,
    this.email,
    this.password,
    this.passwordToken,
    this.birthdate,
    this.phone,
    this.address,
    this.gender,
    this.language,
    this.status,
    this.workerTypeId,
    this.whoEditedIt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.signature,
    this.completedPaperwork,
    this.inactive,
    this.inactiveObservations,
    this.customerRate,
    this.workerRate,
    this.type,
    this.helpersQuantity,
  });

  UserWorker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordToken = json['password_token'];
    birthdate = json['birthdate'];
    phone = json['phone'];
    address = json['address'];
    gender = json['gender'];
    language = json['language'];
    status = json['status'];
    workerTypeId = json['worker_type_id'];
    whoEditedIt = json['who_edited_it'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    signature = json['signature'];
    completedPaperwork = json['completed_paperwork'];
    inactive = json['inactive'];
    inactiveObservations = json['inactive_observations'];
    customerRate = json['customer_rate'];
    workerRate = json['worker_rate'];
    type = json['type'];
    helpersQuantity = json['helpers_quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['password_token'] = passwordToken;
    data['birthdate'] = birthdate;
    data['phone'] = phone;
    data['address'] = address;
    data['gender'] = gender;
    data['language'] = language;
    data['status'] = status;
    data['worker_type_id'] = workerTypeId;
    data['who_edited_it'] = whoEditedIt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['signature'] = signature;
    data['completed_paperwork'] = completedPaperwork;
    data['inactive'] = inactive;
    data['inactive_observations'] = inactiveObservations;
    data['customer_rate'] = customerRate;
    data['worker_rate'] = workerRate;
    data['type'] = type;
    data['helpers_quantity'] = helpersQuantity;
    return data;
  }
}
