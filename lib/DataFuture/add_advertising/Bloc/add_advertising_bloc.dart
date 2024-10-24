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
        var displayImages = await infoRepository.getImagesAdvertising();
        var diplayAdFacilities = await infoRepository.getDiplayAdFacilities();
        var saveAd = await infoRepository.getSaveAd();
        emit(
          DisplayInfoAdvertisingStateResponse(
            displayAdvertising,
            displayImages,
            diplayAdFacilities,
            saveAd,
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
          event.metr,
          event.countRoom,
          event.floor,
          event.yearBuild,
        );
      },
    );
    on<AddImagesToGallery>(
      (event, emit) async {
        await infoRepository.postImagesToGallery(event.images);
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

        var displayAdvertising = await infoRepository.getDiplayAdvertising();
        var displayImages = await infoRepository.getImagesAdvertising();
        var diplayAdFacilities = await infoRepository.getDiplayAdFacilities();
        var saveAd = await infoRepository.getSaveAd();
        emit(
          DisplayInfoAdvertisingStateResponse(
            displayAdvertising,
            displayImages,
            diplayAdFacilities,
            saveAd,
          ),
        );
      },
    );

    on<DeleteImageData>(
      (event, emit) async {
        await infoRepository.getDeleteAdImagesAd(event.idAdGallery);
      },
    );

    on<UpdateImageData>(
      (event, emit) async {
        await infoRepository.getUpdateAdImagesAd(event.images);
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
          isDelete: false,
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
      isDelete: false,
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
            metr: null,
            countRoom: null,
            floor: null,
            yearBuild: null,
            idCt: '',
            address: '',
            title: '',
            description: '',
            price: null,
            images: [],
            idFeature: '',
            document: '',
            view: '',
            province: '',
          ),
        );

  void setParametrInfoAd({
    final num? metr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? address,
    final String? title,
    final String? description,
    final num? price,
    final List<File>? images,
    final String? idFeature,
    final String? document,
    final String? view,
    final String? province,
  }) {
    emit(state.copyWith(
      metr: metr,
      countRoom: countRoom,
      floor: floor,
      yearBuild: yearBuild,
      idCt: idCt,
      address: address,
      title: title,
      description: description,
      price: price,
      images: images,
      idFeature: idFeature,
      document: document,
      view: view,
      province: province,
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
        title: '',
        description: '',
        price: null,
        images: [],
        idFeature: '',
        document: '',
        view: '',
        province: '',
      ),
    );
  }
}
