// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccidentDTO _$AccidentDTOFromJson(Map<String, dynamic> json) => AccidentDTO(
      car: json['car'] as int,
      incident_type: json['incident_type'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$AccidentDTOToJson(AccidentDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'incident_type': instance.incident_type,
      'location': instance.location,
      'image': instance.image,
    };

PostAccidentRepReqDTO _$PostAccidentRepReqDTOFromJson(
        Map<String, dynamic> json) =>
    PostAccidentRepReqDTO(
      car: json['car'] as int,
      incident_type: json['incident_type'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$PostAccidentRepReqDTOToJson(
        PostAccidentRepReqDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'incident_type': instance.incident_type,
      'location': instance.location,
      'image': instance.image,
    };

PostAccidentRepDTO _$PostAccidentRepDTOFromJson(Map<String, dynamic> json) =>
    PostAccidentRepDTO(
      car: json['car'] as int,
      incident_type: json['incident_type'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$PostAccidentRepDTOToJson(PostAccidentRepDTO instance) =>
    <String, dynamic>{
      'car': instance.car,
      'incident_type': instance.incident_type,
      'location': instance.location,
      'image': instance.image,
    };
