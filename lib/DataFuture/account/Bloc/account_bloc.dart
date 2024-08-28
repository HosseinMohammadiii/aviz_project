import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/DataFuture/account/Data/repository/registe_login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAccountBloc extends Bloc<AuthAccountEvent, AuthAccountState> {
  final IAuthRepository _repository;

  AuthAccountBloc(this._repository) : super(AuthInitiateState()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        var loginRequest =
            await _repository.login(event.username, event.password);

        emit(
          AuthResponseState(loginRequest),
        );
      },
    );
    on<AuthRegisterRequest>(
      (event, emit) async {
        var registerRequest = await _repository.register(
          event.username,
          event.password,
          event.passwordConfirm,
        );

        emit(
          AuthResponseState(registerRequest),
        );
      },
    );
  }
}
