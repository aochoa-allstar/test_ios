class Project {
  dynamic id;
  dynamic companyId;
  dynamic customerId;
  dynamic companyMenId;
  dynamic tableIncomeTaxStateId;
  dynamic projectType;
  dynamic name;
  dynamic initialDate;
  dynamic estimatedCompletion;
  dynamic cost;
  dynamic latitude;
  dynamic longitude;
  dynamic description;
  dynamic status;
  dynamic poAfe;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Project(
      {this.id,
      this.companyId,
      this.customerId,
      this.companyMenId,
      this.tableIncomeTaxStateId,
      this.projectType,
      this.name,
      this.initialDate,
      this.estimatedCompletion,
      this.cost,
      this.latitude,
      this.longitude,
      this.description,
      this.status,
      this.poAfe,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    customerId = json['customer_id'];
    companyMenId = json['company_men_id'];
    tableIncomeTaxStateId = json['table_income_tax_state_id'];
    projectType = json['project_type'];
    name = json['name'];
    initialDate = json['initial_date'];
    estimatedCompletion = json['estimated_completion'];
    cost = json['cost'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    status = json['status'];
    poAfe = json['po_afe'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['customer_id'] = customerId;
    data['company_men_id'] = companyMenId;
    data['table_income_tax_state_id'] = tableIncomeTaxStateId;
    data['project_type'] = projectType;
    data['name'] = name;
    data['initial_date'] = initialDate;
    data['estimated_completion'] = estimatedCompletion;
    data['cost'] = cost;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['status'] = status;
    data['po_afe'] = poAfe;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
