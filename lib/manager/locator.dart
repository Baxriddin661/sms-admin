import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:etcsms/manager/local_storage_manager.dart';

import '../config/dio_configurer.dart';
import '../global/shared_data_provider.dart';
import '../repository/rest_client.dart';
import 'loader_manager.dart';



final locator = GetIt.instance;

void setupLocator() {
  HttpOverrides.global = MyHttpOverrides();

  locator.registerSingleton<LocalStorageManager>(LocalStorageManager());
  locator.registerSingleton<SharedData>(SharedData());
  locator.registerSingleton<LoaderManager>(LoaderManager());
  locator.registerSingleton<Logger>(
      Logger(level: Level.all, output: ConsoleOutput()));
  final dioConfigurer =
      locator.registerSingleton<DioConfigurer>(DioConfigurer());
  locator.registerSingleton(RestClient(dioConfigurer.dio));
}
