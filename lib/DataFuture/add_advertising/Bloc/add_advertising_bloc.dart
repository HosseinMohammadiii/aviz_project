import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/category_advertising_repository.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/info_register_ad_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdvertisingBloc
    extends Bloc<AddAdvertisingEvent, AddAdvertisingState> {
  final ICategoryAdvertisingRepository repository;
  final IInfoRegisterAdRepository infoRepository;
  AddAdvertisingBloc(this.repository, this.infoRepository)
      : super(AddAdvertisingInitializedData()) {
    on<AddAdvertisingGetInitializeData>(
      (event, emit) async {
        emit(AddAdvertisingLoading());
        var addCategory = await repository.getCategoryAdvertising();

        emit(AddAdvertisingResponse(
          addCategory,
        ));
      },
    );
    on<AddInfoAdvertising>(
      (event, emit) async {
        var displayInfoRegister = await infoRepository.getDiplayAd(event.idCt);
        var registerInfo = await infoRepository.postRegisterAd(
          event.idCt,
          event.location,
          event.metr,
          event.countRoom,
          event.floor,
          event.yearBuild,
        );
        emit(AddInfoAdvertisingStateResponse(
          displayInfoRegister,
          registerInfo,
        ));
      },
    );
    on<AddFacilitiesAdvertising>(
      (event, emit) async {
        var registerFacilities = await infoRepository.postRegisterFacilities(
          event.elevator,
          event.parking,
          event.storeroom,
          event.balcony,
          event.penthouse,
        );
        var facilitiesAd = await infoRepository.getFacilitiesAdvertising();
        emit(
          RegisterFacilitiesInfoAdvertising(
            registerFacilities,
            facilitiesAd,
          ),
        );
      },
    );
  }
}

class BoolStateCubit extends Cubit<BoolState> {
  BoolStateCubit()
      : super(BoolState(
          elevator: false,
          parking: false,
          storeroom: false,
          balcony: false,
          penthouse: false,
        ));

  void updateBool(String type, bool value) {
    switch (type) {
      case 'آسانسور':
        emit(state.copyWith(elevator: value));
        break;
      case 'پارکینگ':
        emit(state.copyWith(parking: value));
        break;
      case 'انباری':
        emit(state.copyWith(storeroom: value));
        break;
      case 'بالکن':
        emit(state.copyWith(balcony: value));
        break;
      case 'پنت هاوس':
        emit(state.copyWith(penthouse: value));
        break;
    }
  }

  void reset() {
    emit(BoolState(
      elevator: false,
      parking: false,
      storeroom: false,
      balcony: false,
      penthouse: false,
    ));
  }
}

class RegisterInfoAdCubit extends Cubit<RegisterInfoAd> {
  RegisterInfoAdCubit()
      : super(
          RegisterInfoAd(
            metr: 0,
            countRoom: 0,
            floor: 0,
            yearBuild: 0,
            //id: '',
            idCt: '',
            address: '',
          ),
        );

  void setParametrInfoAd({
    required final num metr,
    required final num countRoom,
    required final num floor,
    required final num yearBuild,
    //required final String id,
    required final String idCt,
    required final String address,
  }) {
    emit(state.copyWith(metr: metr));
    emit(state.copyWith(countRoom: countRoom));
    emit(state.copyWith(floor: floor));
    emit(state.copyWith(yearBuild: yearBuild));
    // emit(state.copyWith(id: id));
    emit(state.copyWith(idCt: idCt));
    emit(state.copyWith(address: address));
  }
}
