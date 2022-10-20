import 'package:json_annotation/json_annotation.dart';

part 'operation.g.dart';

@JsonSerializable()
class OperationPlanDTO {
    const OperationPlanDTO(
        {required this.reservation_id,
         required this.operation_plan});
    
    final int reservation_id;
    final String operation_plan;
  
  factory OperationPlanDTO.fromJson(Map<String, dynamic> json) =>
      _$OperationPlanDTOFromJson(json);
  Map<String, dynamic> toJson() => _$OperationPlanDTOToJson(this);
}

@JsonSerializable()
class SafetyCheckDTO {
    const SafetyCheckDTO(
        {required this.reservation_id,
         required this.safety_checklist});
    
    final int reservation_id;
    final bool safety_checklist;
  
  factory SafetyCheckDTO.fromJson(Map<String, dynamic> json) =>
      _$SafetyCheckDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SafetyCheckDTOToJson(this);
}

@JsonSerializable()
class OperationFinishDTO {
    const OperationFinishDTO(
        {required this.reservation_id});
    
    final int reservation_id;
  
  factory OperationFinishDTO.fromJson(Map<String, dynamic> json) =>
      _$OperationFinishDTOFromJson(json);
  Map<String, dynamic> toJson() => _$OperationFinishDTOToJson(this);
}