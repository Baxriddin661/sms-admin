import 'package:dio/dio.dart';
import 'package:etcsms/model/application_model.dart';
import 'package:etcsms/model/create_application_model.dart';
import 'package:etcsms/model/generic/listing_response_model.dart';
import 'package:etcsms/model/template_model.dart';
import 'package:etcsms/model/template_update_model.dart';
import 'package:etcsms/repository/api_constant.dart';
import 'package:retrofit/http.dart';

import '../model/application_update_model.dart';
import '../model/login_response_model.dart';
import '../model/user_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiConstant.login)
  Future<LoginResponseModel> login(
    @Field('login') String login,
    @Field('password') String password,
  );

  @GET(ApiConstant.profileMe)
  Future<UserModel> profileMe(
    @Path('login') String login,
  );

  @GET(ApiConstant.usersList)
  Future<ListingResponseModel<UserModel>> usersList(
    @Queries() Map<String, dynamic> filter,
  );

  @GET(ApiConstant.applicationsList)
  Future<ListingResponseModel<ApplicationModel>> applicationsList(
    @Queries() Map<String, dynamic> filter,
  );

  @GET(ApiConstant.applicationsListByStatus)
  Future<ListingResponseModel<ApplicationModel>> applicationsListByStatus(
    @Queries() Map<String, dynamic> filter,
  );

  @GET(ApiConstant.templateListing)
  Future<ListingResponseModel<TemplateModel>> templateListing(
    @Queries() Map<String, dynamic> filter,
  );

  @POST(ApiConstant.applicationCreate)
  Future<ApplicationModel> applicationCreate(
    @Body() CreateApplicationModel model,
  );

  @POST(ApiConstant.templateCreate)
  Future templateCreate(
    @Body() CreateApplicationModel model,
  );

  @PUT(ApiConstant.updateTemplateStatus)
  Future updateTemplateStatus(@Body() TemplateUpdateModel model);

  @PUT(ApiConstant.updateApplicationStatus)
  Future updateApplicationStatus(@Body() ApplicationUpdateModel model);
}
