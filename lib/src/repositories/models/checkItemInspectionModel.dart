// ignore_for_file: non_constant_identifier_names

class CheckboxItemInspectionModel {
  //final int inspectionID;
  final int preTrip;
  final int postTrip;
  final int requiresRepair;
  final String name;

  CheckboxItemInspectionModel(
      {
      //required this.inspectionID,
      required this.preTrip,
      required this.postTrip,
      required this.requiresRepair,
      required this.name});

  factory CheckboxItemInspectionModel.fromJson(Map<String, dynamic> json) =>
      CheckboxItemInspectionModel(
        // inspectionID: json['inspection_id'],
        preTrip: json['pre_trip'],
        postTrip: json['pos_trip'],
        requiresRepair: json['requires_repair'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        //"inspection_id": inspectionID,
        "prt": preTrip,
        "pot": postTrip,
        "name": name,
        "rr": requiresRepair
      };
}
