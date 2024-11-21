import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/DataFuture/account/Data/repository/registe_login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAccountBloc extends Bloc<AuthAccountEvent, AuthAccountState> {
  final IAuthRepository _repository;

  AuthAccountBloc(this._repository) : super(AuthInitiateState()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthLoadingState());
        var loginRequest =
            await _repository.login(event.username, event.password);

        emit(
          AuthResponseState(loginRequest),
        );
      },
    );
    on<AuthRegisterRequest>(
      (event, emit) async {
        emit(AuthLoadingState());

        var registerRequest = await _repository.register(
          event.username,
          event.password,
        );

        emit(
          AuthResponseState(registerRequest),
        );
      },
    );

    on<DisplayInformationEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var displayUserInformation = await _repository.getDisplayUserInfo();
        emit(DisplayInformationState(displayUserInformation));
      },
    );

    on<UpdateAvataUserEvent>(
      (event, emit) async {
        emit(AuthLoadingUpdateAvatarState());

        await _repository.getUpdateUserInfo(event.avatar);
        var displayUserInformation = await _repository.getDisplayUserInfo();

        emit(DisplayInformationState(displayUserInformation));
      },
    );

    on<UpdateNameUserEvent>(
      (event, emit) async {
        await _repository.getUpdateNameUser(event.name);
        var displayUserInformation = await _repository.getDisplayUserInfo();
        emit(DisplayInformationState(displayUserInformation));
      },
    );

    on<UpdateEmailUserEvent>(
      (event, emit) async {
        await _repository.getUpdateEmailUser(event.email);
        var displayUserInformation = await _repository.getDisplayUserInfo();
        emit(DisplayInformationState(displayUserInformation));
      },
    );

    on<UpdatePhoNumberUserEvent>(
      (event, emit) async {
        emit(AuthLoadingState());

        await _repository.getUpdatePhoneNumberUser(event.phoneNumber);
        var displayUserInformation = await _repository.getDisplayUserInfo();
        emit(DisplayInformationState(displayUserInformation));
      },
    );

    on<UpdateProvinceUserEvent>(
      (event, emit) async {
        await _repository.getUpdateProvinceUser(event.province);
        var displayUserInformation = await _repository.getDisplayUserInfo();
        emit(DisplayInformationState(displayUserInformation));
      },
    );
  }
}
