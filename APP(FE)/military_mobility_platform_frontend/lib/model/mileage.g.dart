// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDTO _$HistoryDTOFromJson(Map<String, dynamic> json) => HistoryDTO(
      id: json['id'] as int,
      departure: json['department'] as String,
      destination: json['arrival'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      totalTime: json['total_time'] as int,
      totalRange: json['total_range'] as int,
      carID: json['car_id'] as int,
    );

Map<String, dynamic> _$HistoryDTOToJson(HistoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'department': instance.departure,
      'arrival': instance.destination,
      'datetime': instance.datetime.toIso8601String(),
      'total_time': instance.totalTime,
      'total_range': instance.totalRange,
      'car_id': instance.carID,
    };

MakeHistoryReqDTO _$MakeHistoryReqDTOFromJson(Map<String, dynamic> json) =>
    MakeHistoryReqDTO(
      departure: json['department'] as String,
      destination: json['arrival'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      totalTime: json['total_time'] as int,
      totalRange: json['total_range'] as int,
      carID: json['car_id'] as int,
    );

Map<String, dynamic> _$MakeHistoryReqDTOToJson(MakeHistoryReqDTO instance) =>
    <String, dynamic>{
      'department': instance.departure,
      'arrival': instance.destination,
      'datetime': instance.datetime.toIso8601String(),
      'total_time': instance.totalTime,
      'total_range': instance.totalRange,
      'car_id': instance.carID,
    };
