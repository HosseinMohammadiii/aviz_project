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
