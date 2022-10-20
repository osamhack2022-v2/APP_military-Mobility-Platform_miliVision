import 'package:json_annotation/json_annotation.dart';

part 'accident.g.dart';

@JsonSerializable()
class AccidentDTO {
    const AccidentDTO(
        {required this.car,
         required this.incident_type,
         required this.location,
         required this.image
         });
    
    final int car;
    final String incident_type;
    final String location;
    final String image;
  
  factory AccidentDTO.fromJson(Map<String, dynamic> json) =>
      _$AccidentDTOFromJson(json);
  Map<String, dynamic> toJson() => _$AccidentDTOToJson(this);
}

typedef GetAccidentRepDTO = List<AccidentDTO>;

@JsonSerializable()
class PostAccidentRepReqDTO {
  const PostAccidentRepReqDTO(
      {required this.car,
       required this.incident_type,
       required this.location,
       required this.image});

  final int car;
  final String incident_type;
  final String location;
  final String image;

  Map<String, dynamic> toJson() => _$PostAccidentRepReqDTOToJson(this);
}

@JsonSerializable()
class PostAccidentRepDTO {
  const PostAccidentRepDTO(
      {required this.car,
       required this.incident_type,
       required this.location,
       required this.image});

  final int car;
  final String incident_type;
  final String location;
  final String image;

  factory PostAccidentRepDTO.fromJson(Map<String, dynamic> json) =>
      _$PostAccidentRepDTOFromJson(json);
}
