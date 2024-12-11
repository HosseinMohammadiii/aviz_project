import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/DataFuture/account/Data/repository/registe_login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthAccountBloc extends Bloc<AuthAccountEvent, AuthAccountState> {
  final IAuthRepository _repository;

  AuthAccountBloc(this._repository) : super(AuthInitiateState()) {
    // Handles login requests
    on<AuthLoginRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AuthLoadingState());
          
          // Calls repository to log in user
          var loginRequest =
              await _repository.login(event.username, event.password);

          // Emits success response state with login data
          emit(
            AuthResponseState(loginRequest),
          );
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles user registration requests
    on<AuthRegisterRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AuthLoadingState());

          // Calls repository to register user
          var registerRequest = await _repository.register(
            event.username,
            event.password,
          );

          // Emits success response state with registration data
          emit(
            AuthResponseState(registerRequest),
          );
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles fetching user information
    on<DisplayInformationEvent>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AuthLoadingState());

          // Calls repository to fetch user information
          var displayUserInformation = await _repository.getDisplayUserInfo();

          // Emits state with user information
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles avatar update for user
    on<UpdateAvataUserEvent>(
      (event, emit) async {
        try {
          // Emits loading state specific to avatar update
          emit(AuthLoadingUpdateAvatarState());

          // Updates avatar in the repository
          await _repository.getUpdateUserInfo(event.avatar);

          // Fetches and emits updated user information
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles updating user's name
    on<UpdateNameUserEvent>(
      (event, emit) async {
        try {
          // Updates user's name in the repository
          await _repository.getUpdateNameUser(event.name);

          // Fetches and emits updated user information
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles updating user's email
    on<UpdateEmailUserEvent>(
      (event, emit) async {
        try {
          // Updates user's email in the repository
          await _repository.getUpdateEmailUser(event.email);

          // Fetches and emits updated user information
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles updating user's phone number
    on<UpdatePhoNumberUserEvent>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AuthLoadingState());

          // Updates phone number in the repository
          await _repository.getUpdatePhoneNumberUser(event.phoneNumber);

          // Fetches and emits updated user information
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );

    // Handles updating user's province
    on<UpdateProvinceUserEvent>(
      (event, emit) async {
        try {
          // Updates province in the repository
          await _repository.getUpdateProvinceUser(event.province);

          // Fetches and emits updated user information
          var displayUserInformation = await _repository.getDisplayUserInfo();
          emit(DisplayInformationState(displayUserInformation));
        } catch (e) {
          // Emits error state on failure
          emit(AuthErrorState());
        }
      },
    );
  }
}

