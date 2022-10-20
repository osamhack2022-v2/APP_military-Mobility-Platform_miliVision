// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationDTO _$ReservationDTOFromJson(Map<String, dynamic> json) =>
    ReservationDTO(
      id: json['id'] as int,
      booker: UserDTO.fromJson(json['booker'] as Map<String, dynamic>),
      mobility: MobilityDTO.fromJson(json['car'] as Map<String, dynamic>),
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      passengers: json['followers_num'] as int,
      startTime: DateTime.parse(json['reservation_start'] as String),
      endTime: DateTime.parse(json['reservation_end'] as String),
      status: json['status'] as int,
    );

Map<String, dynamic> _$ReservationDTOToJson(ReservationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booker': instance.booker,
      'car': instance.mobility,
      'departure': instance.departure,
      'destination': instance.destination,
      'followers_num': instance.passengers,
      'reservation_start': instance.startTime.toIso8601String(),
      'reservation_end': instance.endTime.toIso8601String(),
      'status': instance.status,
    };

MakeReservationReqDTO _$MakeReservationReqDTOFromJson(
        Map<String, dynamic> json) =>
    MakeReservationReqDTO(
      carID: json['car'] as int,
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      startTime: DateTime.parse(json['reservation_start'] as String),
      endTime: DateTime.parse(json['reservation_end'] as String),
      drivingBySelf: json['driving_by_self'] as bool? ?? false,
    );

Map<String, dynamic> _$MakeReservationReqDTOToJson(
        MakeReservationReqDTO instance) =>
    <String, dynamic>{
      'car': instance.carID,
      'departure': instance.departure,
      'destination': instance.destination,
      'reservation_start': instance.startTime.toIso8601String(),
      'reservation_end': instance.endTime.toIso8601String(),
      'driving_by_self': instance.drivingBySelf,
    };

MakeReservationResDTO _$MakeReservationResDTOFromJson(
        Map<String, dynamic> json) =>
    MakeReservationResDTO(
      carID: json['car'] as int,
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      startTime: DateTime.parse(json['reservation_start'] as String),
      endTime: DateTime.parse(json['reservation_end'] as String),
    );

Map<String, dynamic> _$MakeReservationResDTOToJson(
        MakeReservationResDTO instance) =>
    <String, dynamic>{
      'car': instance.carID,
      'departure': instance.departure,
      'destination': instance.destination,
      'reservation_start': instance.startTime.toIso8601String(),
      'reservation_end': instance.endTime.toIso8601String(),
    };
