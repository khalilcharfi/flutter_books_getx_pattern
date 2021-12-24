import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  //@singleton
  //DataConnectionChecker get dataConnectionChecker;

  @lazySingleton
  HiveInterface get hive => Hive;

/*@preResolve // if you need to pre resolve the value
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();*/
}
