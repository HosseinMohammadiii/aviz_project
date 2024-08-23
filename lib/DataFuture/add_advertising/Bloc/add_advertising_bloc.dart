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
    on<AddImagesToGallery>(
      (event, emit) async {
        var registerImages =
            await infoRepository.postImagesToGallery(event.images);
        emit(AddImagesToGalleryStateResponse(registerImages));
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
          event.duplex,
          event.water,
          event.electricity,
          event.gas,
          event.floorMaterial,
          event.wc,
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
          duplex: false,
          water: false,
          electricity: false,
          gas: false,
          floorMaterial: '',
          fIndex: 1,
          wc: '',
          wIndex: 1,
        ));

  void updateTextWC(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(wc: 'ایرانی'));
        break;
      case 1:
        emit(state.copyWith(wc: 'فرنگی'));
        break;
      case 2:
        emit(state.copyWith(wc: 'ایرانی و فرنگی'));
        break;
    }
  }

  void updateTextFM(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(floorMaterial: 'سرامیک'));
        break;
      case 1:
        emit(state.copyWith(floorMaterial: 'موزائیک'));
        break;
      case 2:
        emit(state.copyWith(floorMaterial: 'پارکت'));
        break;
    }
  }

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
      case 'دوبلکس':
        emit(state.copyWith(duplex: value));
        break;
      case 'آب':
        emit(state.copyWith(water: value, floorMaterial: '', wc: ''));
        break;
      case 'برق':
        emit(state.copyWith(electricity: value, floorMaterial: '', wc: ''));
        break;
      case 'گاز':
        emit(state.copyWith(gas: value, floorMaterial: '', wc: ''));
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
      duplex: false,
      water: false,
      electricity: false,
      gas: false,
      floorMaterial: '',
      fIndex: 1,
      wc: '',
      wIndex: 1,
    ));
  }
}

class RegisterInfoAdCubit extends Cubit<RegisterInfoAd> {
  RegisterInfoAdCubit()
      : super(
          RegisterInfoAd(
            metr: null,
            countRoom: null,
            floor: null,
            yearBuild: null,
            idCt: '',
            address: '',
          ),
        );

  void setParametrInfoAd({
    required final num metr,
    required final num countRoom,
    required final num floor,
    required final num yearBuild,
    required final String idCt,
    required final String address,
  }) {
    emit(state.copyWith(
      metr: metr,
      countRoom: countRoom,
      floor: floor,
      yearBuild: yearBuild,
      idCt: idCt,
      address: address,
    ));
  }

  void resetInfoAdSet() {
    emit(
      RegisterInfoAd(
        metr: null,
        countRoom: null,
        floor: null,
        yearBuild: null,
        idCt: '',
        address: '',
      ),
    );
  }
}
