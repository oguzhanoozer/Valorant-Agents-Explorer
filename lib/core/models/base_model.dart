import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract base class BaseModel with EquatableMixin {
  const BaseModel();

  @override
  List<Object?> get props => <Object?>[];

  @override
  bool? get stringify => kDebugMode;
}
