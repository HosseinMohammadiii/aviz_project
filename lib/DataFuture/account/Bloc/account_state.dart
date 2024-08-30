import 'package:dartz/dartz.dart';

abstract class AuthAccountState {}

final class AuthInitiateState extends AuthAccountState {}

final class AuthLoadingState extends AuthAccountState {}

final class AuthResponseState extends AuthAccountState {
  Either<String, String> reponse;
  AuthResponseState(this.reponse);
}

final class AuthTryingState extends AuthAccountState {}
