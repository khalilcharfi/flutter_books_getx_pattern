import 'package:equatable/equatable.dart';

class LocalMessageError with EquatableMixin {
  String? message;
  int? code;

  LocalMessageError({this.message, this.code});

  @override
  List<Object?> get props => [message, code];

  @override
  bool? get stringify => true;
}
