import 'dart:io';

abstract class AuthAccountEvent {}

final class AuthLoginRequest extends AuthAccountEvent {
  String username;
  String password;

  AuthLoginRequest(this.username, this.password);
}

final class AuthRegisterRequest extends AuthAccountEvent {
  String username;
  String password;
  String passwordConfirm;

  AuthRegisterRequest(this.username, this.password, this.passwordConfirm);
}

final class DisplayInformationEvent extends AuthAccountEvent {}

final class UpdateAvataUserEvent extends AuthAccountEvent {
  File avatar;
  UpdateAvataUserEvent(this.avatar);
}

final class UpdateNameUserEvent extends AuthAccountEvent {
  String name;
  UpdateNameUserEvent(this.name);
}

final class UpdateEmailUserEvent extends AuthAccountEvent {
  String email;
  UpdateEmailUserEvent(this.email);
}

final class UpdatePhoNumberUserEvent extends AuthAccountEvent {
  int phoneNumber;
  UpdatePhoNumberUserEvent(this.phoneNumber);
}

final class UpdateProvinceUserEvent extends AuthAccountEvent {
  String province;
  UpdateProvinceUserEvent(this.province);
}