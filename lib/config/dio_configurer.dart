import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:etcsms/manager/loader_manager.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/repository/rest_client.dart';

import '../model/generic/response_data.dart';
import '../repository/api_constant.dart';


class DioConfigurer {
  final dio = Dio()
    ..interceptors.addAll(
      [
        // _CustomInterceptor(),
      ],
    );

  Future<RestClient> attachTokenToDio(String? token) async {
    print("Token  : >>>>>>>>>>>> \n ${token.toString()}");
    dio.options.baseUrl = ApiConstant.baseUrl;
    if (token == null) {
      dio.options.headers
          .remove("Authentication"); // config your dio headers globally
    } else {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    dio.options.headers["Accept"] = "application/json";


    await locator.unregister<RestClient>();
    return locator.registerSingleton<RestClient>(RestClient(dio));
  }
}

class _CustomInterceptor extends dio.Interceptor {
  final Logger logger = locator.get<Logger>();

  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    logger.i(
      "REQUEST >>>> " +
          options.uri.toString() +
          "\n headers : " +
          options.headers.values.toString() +
          "\n body : " +
          options.data.toString(),
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
      dio.Response response, dio.ResponseInterceptorHandler handler) {
    logger.i(
      "RESPONSE >>>> " +
          response.realUri.toString() +
          "\n headers : " +
          response.headers.map.toString() +
          "\n body : " +
          response.data.toString(),
    );
    super.onResponse(response, handler);
  }

  @override
  Future onError(
      dio.DioException err, dio.ErrorInterceptorHandler handler) async {
    print("onError: ${err.response?.statusCode}");

    if (EasyLoading.isShow) {
      loaderManager.hideLoader();
    }
    if (err.response?.statusCode == 401) {
      //todo log out
      return;
    }

    // if (err.response?.statusCode == 500) {
    //   Get.offAllNamed(InternalErrorPage.route);
    //   return;
    // }

    try {
      ResponseData response =
      ResponseData.fromJson(err.response?.data, (object) {});
      if (!response.success) {
        if (response.error != null) {
          loaderManager.showError(response.error!);
        }
      }
    } catch(e) {

    }

    return handler.next(err);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
