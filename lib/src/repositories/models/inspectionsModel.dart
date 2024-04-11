class InspectionsModel {
  final int id;

  final String date;

  final String location;
  final int equipment_id;
  final double odometer_begin;
  final double odometer_end;
  final String remarks;
  final int worker_id;
  final int vehicle_condition;
  final int defects_corrected;
  final int defects_not_corrected;
  final int trailer_1_equipment_id;
  final int trailer_2_equipment_id;
  final String v_condition_signature;
  final String driver_signature;
  final String checkBoxItems;

  InspectionsModel({
    required this.id,
    required this.date,
    required this.location,
    required this.equipment_id,
    required this.odometer_begin,
    required this.odometer_end,
    required this.remarks,
    required this.worker_id,
    required this.vehicle_condition,
    required this.defects_corrected,
    required this.defects_not_corrected,
    required this.trailer_1_equipment_id,
    required this.trailer_2_equipment_id,
    required this.v_condition_signature,
    required this.driver_signature,
    required this.checkBoxItems,
  });

  factory InspectionsModel.fromJson(Map<String, dynamic> json) =>
      InspectionsModel(
        id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
        date: json['date'],
        location: json['location'],
        equipment_id: json['equipment_id'] != null
            ? int.parse(json['equipment_id'].toString())
            : 0,
        odometer_begin: json['odometer_begin'] != null
            ? double.parse(json['odometer_begin'].toString())
            : 0,
        odometer_end: json['odometer_end'] != null
            ? double.parse(json['odometer_end'].toString())
            : 0,
        remarks: json['remarks'],
        worker_id: json['worker_id'] != null
            ? int.parse(json['worker_id'].toString())
            : 0,
        vehicle_condition: json['vehicle_condition'] != null
            ? int.parse(json['vehicle_condition'].toString())
            : 0,
        defects_corrected: json['defects_corrected'] != null
            ? int.parse(json['defects_corrected'].toString())
            : 0,
        defects_not_corrected: json['defects_not_corrected'] != null
            ? int.parse(json['defects_not_corrected'].toString())
            : 0,
        trailer_1_equipment_id: json['trailer_1_equipment_id'] != null
            ? int.parse(json['trailer_1_equipment_id'].toString())
            : 0,
        trailer_2_equipment_id: json['trailer_2_equipment_id'] != null
            ? int.parse(json['trailer_2_equipment_id'].toString())
            : 0,
        v_condition_signature: json['v_condition_signature'],
        driver_signature: json['driver_signature'],
        checkBoxItems: json['checkBoxItems'],
      );
}
