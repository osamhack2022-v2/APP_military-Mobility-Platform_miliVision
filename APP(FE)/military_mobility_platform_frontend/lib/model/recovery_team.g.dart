// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoveryTeamDTO _$RecoveryTeamDTOFromJson(Map<String, dynamic> json) =>
    RecoveryTeamDTO(
      car: json['car'] as int,
      location: json['location'] as String,
      service_needs: json['service_needs'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$RecoveryTeamDTOToJson(RecoveryTeamDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'location': instance.location,
      'service_needs': instance.service_needs,
      'note': instance.note,
    };

PostRecoveryTeamReqDTO _$PostRecoveryTeamReqDTOFromJson(
        Map<String, dynamic> json) =>
    PostRecoveryTeamReqDTO(
      car: json['car'] as int,
      location: json['location'] as String,
      service_needs: json['service_needs'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$PostRecoveryTeamReqDTOToJson(
        PostRecoveryTeamReqDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'location': instance.location,
      'service_needs': instance.service_needs,
      'note': instance.note,
    };

PostRecoveryTeamDTO _$PostRecoveryTeamDTOFromJson(Map<String, dynamic> json) =>
    PostRecoveryTeamDTO(
      car: json['car'] as int,
      location: json['location'] as String,
      service_needs: json['service_needs'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$PostRecoveryTeamDTOToJson(
        PostRecoveryTeamDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'location': instance.location,
      'service_needs': instance.service_needs,
      'note': instance.note,
    };
