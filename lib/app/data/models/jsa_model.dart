import 'dart:convert';

import 'package:onax_app/app/data/models/customer_model.dart';

class JSA {
  dynamic id;
  dynamic companyId;
  dynamic destinationId;
  dynamic customerId;
  dynamic projectId;
  dynamic ticketId;
  dynamic date;
  dynamic hazard;
  dynamic controls;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic workerId;
  dynamic jobDescription;
  dynamic gps;
  dynamic helper;
  dynamic helper2Id;
  dynamic otherWorkerId;
  dynamic steelToadShoes;
  dynamic hardHat;
  dynamic safetyGlasses;
  dynamic h2sMonitor;
  dynamic frClothing;
  dynamic fallProtection;
  dynamic hearingProtection;
  dynamic respirator;
  dynamic otherSafetyEquipment;
  dynamic otherSafetyEquipmentName;
  dynamic failPotential;
  dynamic overheadLift;
  dynamic h2s;
  dynamic pinchPoints;
  dynamic slipTrip;
  dynamic sharpObjects;
  dynamic powerTools;
  dynamic hotColdSurface;
  dynamic pressure;
  dynamic droppedObjects;
  dynamic heavyLifting;
  dynamic weather;
  dynamic flammables;
  dynamic chemicals;
  dynamic otherHazards;
  dynamic otherHazardsName;
  dynamic confinedSpacesPermits;
  dynamic hotWorkPermit;
  dynamic excavationTrenching;
  dynamic oneCall;
  dynamic oneCallNum;
  dynamic lockOutTagOut;
  dynamic fireExtinguisher;
  dynamic inspectionOfEquipment;
  dynamic msdsReview;
  dynamic ladder;
  dynamic permits;
  dynamic otherCheckReview;
  dynamic otherCheckReviewName;
  dynamic weatherCondition;
  dynamic weatherConditionDescription;
  dynamic windDirection;
  dynamic windDirectionDescription;
  dynamic task;
  dynamic musterPoints;
  dynamic recommendedActionsAndProcedures;
  dynamic signature1;
  dynamic signature2;
  dynamic signature3;
  dynamic coords;
  dynamic location;
  dynamic project;
  Customer? customer;

  JSA(
      {this.id,
      this.companyId,
      this.destinationId,
      this.customerId,
      this.projectId,
      this.ticketId,
      this.date,
      this.hazard,
      this.controls,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.workerId,
      this.jobDescription,
      this.gps,
      this.helper,
      this.helper2Id,
      this.otherWorkerId,
      this.steelToadShoes,
      this.hardHat,
      this.safetyGlasses,
      this.h2sMonitor,
      this.frClothing,
      this.fallProtection,
      this.hearingProtection,
      this.respirator,
      this.otherSafetyEquipment,
      this.otherSafetyEquipmentName,
      this.failPotential,
      this.overheadLift,
      this.h2s,
      this.pinchPoints,
      this.slipTrip,
      this.sharpObjects,
      this.powerTools,
      this.hotColdSurface,
      this.pressure,
      this.droppedObjects,
      this.heavyLifting,
      this.weather,
      this.flammables,
      this.chemicals,
      this.otherHazards,
      this.otherHazardsName,
      this.confinedSpacesPermits,
      this.hotWorkPermit,
      this.excavationTrenching,
      this.oneCall,
      this.oneCallNum,
      this.lockOutTagOut,
      this.fireExtinguisher,
      this.inspectionOfEquipment,
      this.msdsReview,
      this.ladder,
      this.permits,
      this.otherCheckReview,
      this.otherCheckReviewName,
      this.weatherCondition,
      this.weatherConditionDescription,
      this.windDirection,
      this.windDirectionDescription,
      this.task,
      this.musterPoints,
      this.recommendedActionsAndProcedures,
      this.signature1,
      this.signature2,
      this.signature3,
      this.coords,
      this.location,
      this.project,
      this.customer});

  JSA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    destinationId = json['destination_id'];
    customerId = json['customer_id'];
    projectId = json['project_id'];
    ticketId = json['ticket_id'];
    date = json['date'];
    hazard = json['hazard'];
    controls = json['controls'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    workerId = json['worker_id'];
    jobDescription = json['job_description'];
    gps = json['gps'];
    helper = json['helper'];
    helper2Id = json['helper2_id'];
    otherWorkerId = json['other_worker_id'];
    steelToadShoes = json['steel_toad_shoes'];
    hardHat = json['hard_hat'];
    safetyGlasses = json['safety_glasses'];
    h2sMonitor = json['h2s_monitor'];
    frClothing = json['fr_clothing'];
    fallProtection = json['fall_protection'];
    hearingProtection = json['hearing_protection'];
    respirator = json['respirator'];
    otherSafetyEquipment = json['other_safety_equipment'];
    otherSafetyEquipmentName = json['other_safety_equipment_name'];
    failPotential = json['fail_potential'];
    overheadLift = json['overhead_lift'];
    h2s = json['h2s'];
    pinchPoints = json['pinch_points'];
    slipTrip = json['slip_trip'];
    sharpObjects = json['sharp_objects'];
    powerTools = json['power_tools'];
    hotColdSurface = json['hot_cold_surface'];
    pressure = json['pressure'];
    droppedObjects = json['dropped_objects'];
    heavyLifting = json['heavy_lifting'];
    weather = json['weather'];
    flammables = json['flammables'];
    chemicals = json['chemicals'];
    otherHazards = json['other_hazards'];
    otherHazardsName = json['other_hazards_name'];
    confinedSpacesPermits = json['confined_spaces_permits'];
    hotWorkPermit = json['hot_work_permit'];
    excavationTrenching = json['excavation_trenching'];
    oneCall = json['one_call'];
    oneCallNum = json['one_call_num'];
    lockOutTagOut = json['lock_out_tag_out'];
    fireExtinguisher = json['fire_extinguisher'];
    inspectionOfEquipment = json['inspection_of_equipment'];
    msdsReview = json['msds_review'];
    ladder = json['ladder'];
    permits = json['permits'];
    otherCheckReview = json['other_check_review'];
    otherCheckReviewName = json['other_check_review_name'];
    weatherCondition = json['weather_condition'];
    weatherConditionDescription = json['weather_condition_description'];
    windDirection = json['wind_direction'];
    windDirectionDescription = json['wind_direction_description'];
    task = json['task'];
    musterPoints = json['muster_points'];
    recommendedActionsAndProcedures =
        json['recommended_actions_and_procedures'];
    signature1 = json['signature1'];
    signature2 = json['signature2'];
    signature3 = json['signature3'];
    coords = json['coords'];
    location = json['location'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['destination_id'] = destinationId;
    data['customer_id'] = customerId;
    data['project_id'] = projectId;
    data['ticket_id'] = ticketId;
    data['date'] = date;
    data['hazard'] = hazard;
    data['controls'] = controls;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['worker_id'] = workerId;
    data['job_description'] = jobDescription;
    data['gps'] = gps;
    data['helper'] = helper;
    data['helper2_id'] = helper2Id;
    data['other_worker_id'] = otherWorkerId;
    data['steel_toad_shoes'] = steelToadShoes;
    data['hard_hat'] = hardHat;
    data['safety_glasses'] = safetyGlasses;
    data['h2s_monitor'] = h2sMonitor;
    data['fr_clothing'] = frClothing;
    data['fall_protection'] = fallProtection;
    data['hearing_protection'] = hearingProtection;
    data['respirator'] = respirator;
    data['other_safety_equipment'] = otherSafetyEquipment;
    data['other_safety_equipment_name'] = otherSafetyEquipmentName;
    data['fail_potential'] = failPotential;
    data['overhead_lift'] = overheadLift;
    data['h2s'] = h2s;
    data['pinch_points'] = pinchPoints;
    data['slip_trip'] = slipTrip;
    data['sharp_objects'] = sharpObjects;
    data['power_tools'] = powerTools;
    data['hot_cold_surface'] = hotColdSurface;
    data['pressure'] = pressure;
    data['dropped_objects'] = droppedObjects;
    data['heavy_lifting'] = heavyLifting;
    data['weather'] = weather;
    data['flammables'] = flammables;
    data['chemicals'] = chemicals;
    data['other_hazards'] = otherHazards;
    data['other_hazards_name'] = otherHazardsName;
    data['confined_spaces_permits'] = confinedSpacesPermits;
    data['hot_work_permit'] = hotWorkPermit;
    data['excavation_trenching'] = excavationTrenching;
    data['one_call'] = oneCall;
    data['one_call_num'] = oneCallNum;
    data['lock_out_tag_out'] = lockOutTagOut;
    data['fire_extinguisher'] = fireExtinguisher;
    data['inspection_of_equipment'] = inspectionOfEquipment;
    data['msds_review'] = msdsReview;
    data['ladder'] = ladder;
    data['permits'] = permits;
    data['other_check_review'] = otherCheckReview;
    data['other_check_review_name'] = otherCheckReviewName;
    data['weather_condition'] = weatherCondition;
    data['weather_condition_description'] = weatherConditionDescription;
    data['wind_direction'] = windDirection;
    data['wind_direction_description'] = windDirectionDescription;
    data['task'] = task;
    data['muster_points'] = musterPoints;
    data['recommended_actions_and_procedures'] =
        recommendedActionsAndProcedures;
    data['signature1'] = signature1;
    data['signature2'] = signature2;
    data['signature3'] = signature3;
    data['coords'] = coords;
    data['location'] = location;
    data['project'] = project;
    return data;
  }

  static Map<String, dynamic> toLocalDataBaseJson(Map<String, dynamic> data) {
    final newData = <String, dynamic>{};
    newData['id'] = data['id'];
    newData['company_id'] = data['company_id'];
    newData['destination_id'] = data['destination_id'];
    newData['customer_id'] = data['customer_id'];
    newData['project_id'] = data['project_id'];
    newData['ticket_id'] = data['ticket_id'];
    newData['date'] = data['date'];
    newData['hazard'] = data['hazard'];
    newData['controls'] = data['controls'];
    newData['created_at'] = data['created_at'];
    newData['updated_at'] = data['updated_at'];
    newData['deleted_at'] = data['deleted_at'];
    newData['worker_id'] = data['worker_id'];
    newData['job_description'] = data['job_description'];
    newData['gps'] = data['gps'];
    newData['helper'] = data['helper'];
    newData['helper2_id'] = data['helper2_id'];
    newData['other_worker_id'] = data['other_worker_id'];
    newData['steel_toad_shoes'] = data['steel_toad_shoes'];
    newData['hard_hat'] = data['hard_hat'];
    newData['safety_glasses'] = data['safety_glasses'];
    newData['h2s_monitor'] = data['h2s_monitor'];
    newData['fr_clothing'] = data['fr_clothing'];
    newData['fall_protection'] = data['fall_protection'];
    newData['hearing_protection'] = data['hearing_protection'];
    newData['respirator'] = data['respirator'];
    newData['other_safety_equipment'] = data['other_safety_equipment'];
    newData['other_safety_equipment_name'] =
        data['other_safety_equipment_name'];
    newData['fail_potential'] = data['fail_potential'];
    newData['overhead_lift'] = data['overhead_lift'];
    newData['h2s'] = data['h2s'];
    newData['pinch_points'] = data['pinch_points'];
    newData['slip_trip'] = data['slip_trip'];
    newData['sharp_objects'] = data['sharp_objects'];
    newData['power_tools'] = data['power_tools'];
    newData['hot_cold_surface'] = data['hot_cold_surface'];
    newData['pressure'] = data['pressure'];
    newData['dropped_objects'] = data['dropped_objects'];
    newData['heavy_lifting'] = data['heavy_lifting'];
    newData['weather'] = data['weather'];
    newData['flammables'] = data['flammables'];
    newData['chemicals'] = data['chemicals'];
    newData['other_hazards'] = data['other_hazards'];
    newData['other_hazards_name'] = data['other_hazards_name'];
    newData['confined_spaces_permits'] = data['confined_spaces_permits'];
    newData['hot_work_permit'] = data['hot_work_permit'];
    newData['excavation_trenching'] = data['excavation_trenching'];
    newData['one_call'] = data['one_call'];
    newData['one_call_num'] = data['one_call_num'];
    newData['lock_out_tag_out'] = data['lock_out_tag_out'];
    newData['fire_extinguisher'] = data['fire_extinguisher'];
    newData['inspection_of_equipment'] = data['inspection_of_equipment'];
    newData['msds_review'] = data['msds_review'];
    newData['ladder'] = data['ladder'];
    newData['permits'] = data['permits'];
    newData['other_check_review'] = data['other_check_review'];
    newData['other_check_review_name'] = data['other_check_review_name'];
    newData['weather_condition'] = data['weather_condition'];
    newData['weather_condition_description'] =
        data['weather_condition_description'];
    newData['wind_direction'] = data['wind_direction'];
    newData['wind_direction_description'] = data['wind_direction_description'];
    newData['task'] = data['task'];
    newData['muster_points'] = data['muster_points'];
    newData['recommended_actions_and_procedures'] =
        data['recommended_actions_and_procedures'];
    newData['signature1'] = data['signature1'];
    newData['signature2'] = data['signature2'];
    newData['signature3'] = data['signature3'];
    newData['coords'] = data['coords'];
    newData['location'] = data['location'];
    newData['project'] = data['project'];
    newData["additional_signatures"] =
        jsonEncode(data["additional_signatures"]);
    return newData;
  }

  static Map<String, dynamic> fromLocalDataBaseJson(Map<String, dynamic> data) {
    final newData = <String, dynamic>{};
    newData['id'] = data['id'];
    newData['company_id'] = data['company_id'];
    newData['destination_id'] = data['destination_id'];
    newData['customer_id'] = data['customer_id'];
    newData['project_id'] = data['project_id'];
    newData['ticket_id'] = data['ticket_id'];
    newData['date'] = data['date'];
    newData['hazard'] = data['hazard'];
    newData['controls'] = data['controls'];
    newData['created_at'] = data['created_at'];
    newData['updated_at'] = data['updated_at'];
    newData['deleted_at'] = data['deleted_at'];
    newData['worker_id'] = data['worker_id'];
    newData['job_description'] = data['job_description'];
    newData['gps'] = data['gps'];
    newData['helper'] = data['helper'];
    newData['helper2_id'] = data['helper2_id'];
    newData['other_worker_id'] = data['other_worker_id'];
    newData['steel_toad_shoes'] = data['steel_toad_shoes'];
    newData['hard_hat'] = data['hard_hat'];
    newData['safety_glasses'] = data['safety_glasses'];
    newData['h2s_monitor'] = data['h2s_monitor'];
    newData['fr_clothing'] = data['fr_clothing'];
    newData['fall_protection'] = data['fall_protection'];
    newData['hearing_protection'] = data['hearing_protection'];
    newData['respirator'] = data['respirator'];
    newData['other_safety_equipment'] = data['other_safety_equipment'];
    newData['other_safety_equipment_name'] =
        data['other_safety_equipment_name'];
    newData['fail_potential'] = data['fail_potential'];
    newData['overhead_lift'] = data['overhead_lift'];
    newData['h2s'] = data['h2s'];
    newData['pinch_points'] = data['pinch_points'];
    newData['slip_trip'] = data['slip_trip'];
    newData['sharp_objects'] = data['sharp_objects'];
    newData['power_tools'] = data['power_tools'];
    newData['hot_cold_surface'] = data['hot_cold_surface'];
    newData['pressure'] = data['pressure'];
    newData['dropped_objects'] = data['dropped_objects'];
    newData['heavy_lifting'] = data['heavy_lifting'];
    newData['weather'] = data['weather'];
    newData['flammables'] = data['flammables'];
    newData['chemicals'] = data['chemicals'];
    newData['other_hazards'] = data['other_hazards'];
    newData['other_hazards_name'] = data['other_hazards_name'];
    newData['confined_spaces_permits'] = data['confined_spaces_permits'];
    newData['hot_work_permit'] = data['hot_work_permit'];
    newData['excavation_trenching'] = data['excavation_trenching'];
    newData['one_call'] = data['one_call'];
    newData['one_call_num'] = data['one_call_num'];
    newData['lock_out_tag_out'] = data['lock_out_tag_out'];
    newData['fire_extinguisher'] = data['fire_extinguisher'];
    newData['inspection_of_equipment'] = data['inspection_of_equipment'];
    newData['msds_review'] = data['msds_review'];
    newData['ladder'] = data['ladder'];
    newData['permits'] = data['permits'];
    newData['other_check_review'] = data['other_check_review'];
    newData['other_check_review_name'] = data['other_check_review_name'];
    newData['weather_condition'] = data['weather_condition'];
    newData['weather_condition_description'] =
        data['weather_condition_description'];
    newData['wind_direction'] = data['wind_direction'];
    newData['wind_direction_description'] = data['wind_direction_description'];
    newData['task'] = data['task'];
    newData['muster_points'] = data['muster_points'];
    newData['recommended_actions_and_procedures'] =
        data['recommended_actions_and_procedures'];
    newData['signature1'] = data['signature1'];
    newData['signature2'] = data['signature2'];
    newData['signature3'] = data['signature3'];
    newData['coords'] = data['coords'];
    newData['location'] = data['location'];
    newData['project'] = data['project'];
    newData["additional_signatures"] = data["additional_signatures"] != null
        ? jsonDecode(data["additional_signatures"])
        : [];
    return newData;
  }
}
