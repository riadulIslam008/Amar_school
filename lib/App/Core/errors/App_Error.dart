import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String errorMerrsage;

  const AppError(this.errorMerrsage);

  @override
  List<Object> get props => [errorMerrsage];
}

