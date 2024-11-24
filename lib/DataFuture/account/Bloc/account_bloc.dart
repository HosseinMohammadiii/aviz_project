import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/DataFuture/account/Data/repository/registe_login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAccountBloc extends Bloc<AuthAccountEvent, AuthAccountState> {
  final IAuthRepository _repository;

  AuthAccountBloc(this._repository) : super(AuthInitiateState()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());
          var loginRequest =
              await _repository.login(event.username, event.password);

          emit(
            AuthResponseState(loginRequest),
          );
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );
    on<AuthRegisterRequest>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());

          var registerRequest = await _repository.register(
            event.username,
            event.password,
          );

          emit(
            AuthResponseState(registerRequest),
          );
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<DisplayInformationEvent>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<UpdateAvataUserEvent>(
      (event, emit) async {
        try {
          emit(AuthLoadingUpdateAvatarState());

          await _repository.getUpdateUserInfo(event.avatar);
          var displayUserInformation = await _repository.getDisplayUserInfo();

          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<UpdateNameUserEvent>(
      (event, emit) async {
        try {
          await _repository.getUpdateNameUser(event.name);
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<UpdateEmailUserEvent>(
      (event, emit) async {
        try {
          await _repository.getUpdateEmailUser(event.email);
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<UpdatePhoNumberUserEvent>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());

          await _repository.getUpdatePhoneNumberUser(event.phoneNumber);
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );

    on<UpdateProvinceUserEvent>(
      (event, emit) async {
        try {
          await _repository.getUpdateProvinceUser(event.province);
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          emit(AuthErrorState());
        }
      },
    );
  }
}
