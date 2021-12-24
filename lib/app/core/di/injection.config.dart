// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/local/repos/local_book_repo.dart' as _i5;
import '../../data/repos/abstract/book_repo.dart' as _i7;
import '../../data/repos/book_repo_impl.dart' as _i8;
import '../../modules/book_detail/controllers/book_detail_controller.dart'
    as _i10;
import '../../modules/home/controllers/home_controller.dart' as _i9;
import '../../services/book_service.dart' as _i3;
import '../../services/validator_service.dart' as _i6;
import 'register_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.BookService>(() => _i3.BookService());
  gh.lazySingleton<_i4.HiveInterface>(() => registerModule.hive);
  gh.factory<_i5.LocalBookRepo>(
      () => _i5.LocalBookRepoImpl(hive: get<_i4.HiveInterface>()));
  gh.lazySingleton<_i6.ValidatorService>(() => _i6.ValidatorService());
  gh.factory<_i7.BookRepo>(() => _i8.BookRepoImpl(get<_i5.LocalBookRepo>()));
  gh.factory<_i9.HomeController>(
      () => _i9.HomeController(get<_i3.BookService>(), get<_i7.BookRepo>()));
  gh.factory<_i10.BookDetailController>(() => _i10.BookDetailController(
      get<_i7.BookRepo>(),
      get<_i6.ValidatorService>(),
      get<_i3.BookService>()));
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {}
