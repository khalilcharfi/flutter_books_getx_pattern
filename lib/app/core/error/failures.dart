import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:interview/generated/locales.g.dart';

/// for Repo Layer
abstract class Failure {}

class CacheFailure extends Failure with EquatableMixin {
  String? message;

  CacheFailure({this.message});

  @override
  String toString() {
    return message ?? LocaleKeys.cache_failure.tr;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}