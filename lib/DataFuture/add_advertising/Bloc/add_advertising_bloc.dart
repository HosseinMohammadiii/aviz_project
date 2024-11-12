import 'dart:io';

import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/info_register_ad_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdvertisingBloc
    extends Bloc<InfoAdvertisingEvent, AddAdvertisingState> {
  final IInfoAdRepository infoRepository;
  AddAdvertisingBloc(this.infoRepository)
      : super(AddAdvertisingInitializedData()) {
    on<InitializedDisplayAdvertising>(
      (event, emit) async {
        emit(AddAdvertisingLoading());
        var displayAdvertising = await infoRepository.getDiplayAdvertising();
        var diplayAdFacilities = await infoRepository.getDiplayAdFacilities();
        emit(
          DisplayInfoAdvertisingStateResponse(
            displayAdvertising,
            diplayAdFacilities,
          ),
        );
      },
    );
    on<AddInfoAdvertising>(
      (event, emit) async {
        await infoRepository.postRegisterAd(
          event.idCt,
          event.idFeature,
          event.province,
          event.location,
          event.title,
          event.description,
          event.price,
          event.rentPrice,
          event.metr,
          event.buildingMetr,
          event.countRoom,
          event.floor,
          event.yearBuild,
        );
      },
    );
    on<AddImagesToGallery>(
      (event, emit) async {
        emit(AddAdvertisingImageLoading());
        var postImage = await infoRepository.postImagesToGallery(event.images);
        emit(PostImageAdState(postImage));
      },
    );
    on<AddFacilitiesAdvertising>(
      (event, emit) async {
        await infoRepository.postRegisterFacilities(
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
      },
    );
    on<UpdateFacilitiesData>(
      (event, emit) async {
        await infoRepository.getUpdateAdFacilities(
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
      },
    );

    on<DeleteAdvertisingData>(
      (event, emit) async {
        await infoRepository.getDeleteAd(event.idAd);

        await infoRepository.getDeleteAdImagesAd(event.idAdGallery);

        await infoRepository.getDeleteAdFacilities(event.idAdFacilities);
        emit(AddAdvertisingLoading());
        var displayAdvertising = await infoRepository.getDiplayAdvertising();
        var diplayAdFacilities = await infoRepository.getDiplayAdFacilities();
        emit(
          DisplayInfoAdvertisingStateResponse(
            displayAdvertising,
            diplayAdFacilities,
          ),
        );
      },
    );
    on<DeleteFacilitiesData>(
      (event, emit) async {
        await infoRepository.getDeleteAdFacilities(event.idAdFacilities);
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
          isUpdate: false,
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
      isUpdate: false,
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
            uploadProgress: null,
            metr: null,
            stateRentHome: null,
            buildingMetr: null,
            countRoom: null,
            floor: null,
            yearBuild: null,
            idCt: '',
            province: '',
            title: '',
            description: '',
            price: null,
            rentPrice: null,
            images: [],
            idFeature: '',
            document: '',
            view: '',
            city: '',
          ),
        );

  void setParametrInfoAd({
    final bool? uploadProgress,
    final bool? stateRentHome,
    final num? metr,
    final num? buildingMetr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? province,
    final String? title,
    final String? description,
    final num? price,
    final num? rentPrice,
    final List<File>? images,
    final String? idFeature,
    final String? document,
    final String? view,
    final String? city,
  }) {
    emit(state.copyWith(
      uploadProgress: uploadProgress,
      stateRentHome: stateRentHome,
      metr: metr,
      buildingMetr: buildingMetr,
      countRoom: countRoom,
      floor: floor,
      yearBuild: yearBuild,
      idCt: idCt,
      province: province,
      title: title,
      description: description,
      price: price,
      rentPrice: rentPrice,
      images: images,
      idFeature: idFeature,
      document: document,
      view: view,
      city: city,
    ));
  }

  void resetInfoAdSet() {
    emit(
      RegisterInfoAd(
        metr: null,
        stateRentHome: null,
        buildingMetr: null,
        countRoom: null,
        floor: null,
        yearBuild: null,
        idCt: '',
        province: '',
        title: '',
        description: '',
        price: null,
        rentPrice: null,
        images: [],
        idFeature: '',
        document: '',
        view: '',
        city: '',
      ),
    );
  }
}
