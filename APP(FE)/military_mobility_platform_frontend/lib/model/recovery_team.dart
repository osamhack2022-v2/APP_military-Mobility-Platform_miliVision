import 'package:json_annotation/json_annotation.dart';

part 'recovery_team.g.dart';

@JsonSerializable()
class RecoveryTeamDTO {
    const RecoveryTeamDTO(
        {required this.car,
         required this.location,
         required this.service_needs,
         required this.note});
    
    final int car;
    final String location;
    final String service_needs;
    final String note;

  
  factory RecoveryTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$RecoveryTeamDTOFromJson(json);
  Map<String, dynamic> toJson() => _$RecoveryTeamDTOToJson(this);
}

typedef GetRecoveryTeamDTO = List<RecoveryTeamDTO>;

@JsonSerializable()
class PostRecoveryTeamReqDTO {
  const PostRecoveryTeamReqDTO(
      {required this.car,
       required this.location,
       required this.service_needs,
       required this.note});

  final int car;
  final String location;
  final String service_needs;
  final String note;

  Map<String, dynamic> toJson() => _$PostRecoveryTeamReqDTOToJson(this);
}

@JsonSerializable()
class PostRecoveryTeamDTO {
  const PostRecoveryTeamDTO(
      {required this.car,
       required this.location,
       required this.service_needs,
       required this.note});

  final int car;
  final String location;
  final String service_needs;
  final String note;

  factory PostRecoveryTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$PostRecoveryTeamDTOFromJson(json);
}