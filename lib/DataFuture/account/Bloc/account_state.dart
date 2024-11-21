import 'package:aviz_project/DataFuture/account/Data/model/account.dart';
import 'package:dartz/dartz.dart';

abstract class AuthAccountState {}

final class AuthInitiateState extends AuthAccountState {}

final class AuthLoadingState extends AuthAccountState {}

final class AuthLoadingUpdateAvatarState extends AuthAccountState {}

final class AuthResponseState extends AuthAccountState {
  Either<String, String> response;
  AuthResponseState(this.response);
}

final class DisplayInformationState extends AuthAccountState {
  Either<String, AccountInformation> displayUserInformation;
  DisplayInformationState(this.displayUserInformation);
}
