abstract class ApiConstant {
  static const String baseUrl = "https://allied-texture-fifth-assessing.trycloudflare.com";
  static const String login = "/api/v1/main/auth/login";
  static const String profileMe = "/api/v1/abonents/retrieve/{login}";
  static const String usersList = "/api/v1/abonents/all";
  static const String applicationsList = "/api/v1/main/application/get-all";
  static const String applicationsListByStatus = "/api/v1/main/application/get-all-by-status";
  static const String applicationCreate = "/api/v1/main/application/create";
  static const String updateApplicationStatus = "/api/v1/main/application/update/status";
  static const String templateListing =
      "/api/v1/main/template/get-by-application-id";
  static const String templateCreate = "/api/v1/main/template/create";
  static const String updateTemplateStatus = "/api/v1/main/template/update-status";
}
