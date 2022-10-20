// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationPlanDTO _$OperationPlanDTOFromJson(Map<String, dynamic> json) =>
    OperationPlanDTO(
      reservation_id: json['reservation_id'] as int,
      operation_plan: json['operation_plan'] as String,
    );

Map<String, dynamic> _$OperationPlanDTOToJson(OperationPlanDTO instance) =>
    <String, dynamic>{
      'reservation_id': instance.reservation_id,
      'operation_plan': instance.operation_plan,
    };

SafetyCheckDTO _$SafetyCheckDTOFromJson(Map<String, dynamic> json) =>
    SafetyCheckDTO(
      reservation_id: json['reservation_id'] as int,
      safety_checklist: json['safety_checklist'] as bool,
    );

Map<String, dynamic> _$SafetyCheckDTOToJson(SafetyCheckDTO instance) =>
    <String, dynamic>{
      'reservation_id': instance.reservation_id,
      'safety_checklist': instance.safety_checklist,
    };

OperationFinishDTO _$OperationFinishDTOFromJson(Map<String, dynamic> json) =>
    OperationFinishDTO(
      reservation_id: json['reservation_id'] as int,
    );

Map<String, dynamic> _$OperationFinishDTOToJson(OperationFinishDTO instance) =>
    <String, dynamic>{
      'reservation_id': instance.reservation_id,
    };
