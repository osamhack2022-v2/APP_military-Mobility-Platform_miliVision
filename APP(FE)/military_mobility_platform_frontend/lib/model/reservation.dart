import 'package:json_annotation/json_annotation.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/model/user.dart';

part 'reservation.g.dart';

@JsonSerializable()
class ReservationDTO {
  const ReservationDTO(
      {required this.id,
      required this.booker,
      required this.mobility,
      required this.departure,
      required this.destination,
      required this.passengers,
      required this.startTime,
      required this.endTime,
      required this.status});

  final int id;
  final UserDTO booker;
  @JsonKey(name: 'car')
  final MobilityDTO mobility;
  final String departure;
  final String destination;
  @JsonKey(name: 'followers_num')
  final int passengers;
  @JsonKey(name: 'reservation_start')
  final DateTime startTime;
  @JsonKey(name: 'reservation_end')
  final DateTime endTime;
  final int status;

  bool get waiting => status == 0;
  bool get accepted => status == 1;

  factory ReservationDTO.fromJson(Map<String, dynamic> json) =>
      _$ReservationDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationDTOToJson(this);
}

typedef GetReservationsResDTO = List<ReservationDTO>;

@JsonSerializable()
class MakeReservationReqDTO {
  const MakeReservationReqDTO(
      {required this.carID,
      required this.departure,
      required this.destination,
      required this.startTime,
      required this.endTime,
      this.drivingBySelf = false});

  @JsonKey(name: 'car')
  final int carID;
  final String departure;
  final String destination;
  @JsonKey(name: 'reservation_start')
  final DateTime startTime;
  @JsonKey(name: 'reservation_end')
  final DateTime endTime;
  @JsonKey(name: 'driving_by_self')
  final bool drivingBySelf;

  Map<String, dynamic> toJson() => _$MakeReservationReqDTOToJson(this);
}

@JsonSerializable()
class MakeReservationResDTO {
  const MakeReservationResDTO(
      {required this.carID,
      required this.departure,
      required this.destination,
      required this.startTime,
      required this.endTime});

  @JsonKey(name: 'car')
  final int carID;
  final String departure;
  final String destination;
  @JsonKey(name: 'reservation_start')
  final DateTime startTime;
  @JsonKey(name: 'reservation_end')
  final DateTime endTime;

  factory MakeReservationResDTO.fromJson(Map<String, dynamic> json) =>
      _$MakeReservationResDTOFromJson(json);
}
