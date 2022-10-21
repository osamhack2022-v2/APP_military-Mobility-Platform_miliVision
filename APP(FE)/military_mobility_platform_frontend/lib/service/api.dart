import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:military_mobility_platform_frontend/model/mileage.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/model/user.dart';
import 'package:military_mobility_platform_frontend/model/operation.dart';
import 'package:military_mobility_platform_frontend/model/accident.dart';
import 'package:military_mobility_platform_frontend/model/recovery_team.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: "http://20.214.203.20:8000")
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @POST('/user/login')
  Future<LoginResDTO> login(@Body() LoginReqDTO dto);

  @POST('/user/register')
  Future<RegisterResDTO> register(@Body() RegisterReqDTO dto);

  @POST('/tms/get_available_car')
  Future<GetAvailableMobilitiesResDTO> getAvailableMobilities(
      @Body() GetAvailableMobilitiesReqDTO dto);

  @GET('/tms/reservation')
  Future<GetReservationsResDTO> getReservations();

  @POST('/tms/reservation')
  Future<MakeReservationResDTO> makeReservation(
      @Body() MakeReservationReqDTO dto);

  @DELETE('/tms/reservation')
  Future<void> deleteReservation(@Query('reservation_id') int reservationID);

  @POST('/mileage/history')
  Future<HistoryDTO> makeHistory(@Body() MakeHistoryReqDTO dto);

  @GET('/mileage/history')
  Future<GetHistoriesResDTO> getHistories();

  @POST('/tms/safety_checklist')
  Future<void> confirmSafetyCheck(@Body() SafetyCheckDTO dto);

  @POST('/tms/add_operation_plan')
  Future<void> makeOperationPlan(@Body() OperationPlanDTO dto);

  @GET('/tms/finish_using')
  Future<void> returnVehicle(@Query("reservation_id") int reservationID);

  @GET('/incident/incident')
  Future<GetAccidentRepDTO> getAccidentReport();

  @MultiPart()
  @POST('/incident/incident')
  Future<PostAccidentRepDTO> postAccidentReport(
      @Part() int car,
      @Part() String incident_type,
      @Part() String location,
      @Part() File image);

  @GET('/incident/rescue')
  Future<GetRecoveryTeamDTO> getRecoveryTeam();

  @POST('/incident/rescue')
  Future<PostRecoveryTeamDTO> postRecoveryTeam(
      @Body() PostRecoveryTeamReqDTO dto);
}
