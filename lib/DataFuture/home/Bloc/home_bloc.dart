import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_state.dart';
import 'package:aviz_project/DataFuture/home/Data/repository/home_repository.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitializeState()) {
    on<HomeGetInitializeData>(
      (event, emit) async {
        emit(HomeLoadingState());
        var getAdvertising = await homeRepository.getAdvertising();

        var advertisingFacilitiesDeatail =
            await homeRepository.getDiplayFacilitiesAd();
        var advertisingSaveAd = await homeRepository.getSaveAd();

        emit(
          HomeRequestSuccessState(
            getAdvertising,
            advertisingFacilitiesDeatail,
            advertisingSaveAd,
          ),
        );
      },
    );
  }
}
