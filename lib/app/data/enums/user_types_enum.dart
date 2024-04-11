enum UserTypes {
  worker(0),
  companyMan(1);

  const UserTypes(this.userTypeId);

  final int userTypeId;

  int get id => this.userTypeId;

  dynamic fromId(id) {
    return UserTypes.values[id];
  }
}
