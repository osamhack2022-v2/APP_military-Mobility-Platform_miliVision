import 'package:json_annotation/json_annotation.dart';

part 'mileage.g.dart';

@JsonSerializable()
class HistoryDTO {
  const HistoryDTO(
      {required this.id,
      required this.departure,
      required this.destination,
      required this.datetime,
      required this.totalTime,
      required this.totalRange,
      required this.carID});

  final int id;
  @JsonKey(name: 'department')
  final String departure;
  @JsonKey(name: 'arrival')
  final String destination;
  final DateTime datetime;
  @JsonKey(name: 'total_time')
  final int totalTime;
  @JsonKey(name: 'total_range')
  final int totalRange;
  @JsonKey(name: 'car_id')
  final int carID;

  factory HistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$HistoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryDTOToJson(this);
}

@JsonSerializable()
class MakeHistoryReqDTO {
  const MakeHistoryReqDTO(
      {required this.departure,
      required this.destination,
      required this.datetime,
      required this.totalTime,
      required this.totalRange,
      required this.carID});

  @JsonKey(name: 'department')
  final String departure;
  @JsonKey(name: 'arrival')
  final String destination;
  final DateTime datetime;
  @JsonKey(name: 'total_time')
  final int totalTime;
  @JsonKey(name: 'total_range')
  final int totalRange;
  @JsonKey(name: 'car_id')
  final int carID;

  Map<String, dynamic> toJson() => _$MakeHistoryReqDTOToJson(this);
}

typedef GetHistoriesResDTO = List<HistoryDTO>;
