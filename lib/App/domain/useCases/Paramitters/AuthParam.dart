import 'package:equatable/equatable.dart';

class AuthParam extends Equatable {
  final String userName;
  final String userPassword;

  AuthParam(this.userName, this.userPassword);

  @override
  List<Object> get props => throw UnimplementedError();
}
