import 'package:aviz_project/DataFuture/province/Bloc/province_state.dart';
import 'package:aviz_project/DataFuture/province/Data/datasource/province_datasource.dart';
import 'package:aviz_project/DataFuture/province/Data/repository/province_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'province_event.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final repository = ProvinceRepositoryRemoot(ProvinceDatasourceRemoot());

  ProvinceBloc() : super(ProvinceinitializedState()) {
    on<ProvinceInitializedData>(
      (event, emit) async {
        try {
          emit(ProvinceLoadindState());
          var province = await repository.provices(event.province);
          var cities = await repository.provicesCities(event.city);

          emit(ProvinceRsultSuccessResponse(province, cities));
        } catch (e) {
          emit(ProvinceHandleErrorState());
        }
      },
    );
    on<ProvinceSearchEvent>(
      (event, emit) async {
        try {
          var province = await repository.provices(event.province);
          var cities = await repository.provicesCities(event.province);
          emit(ProvinceSuccessResponse(province, cities));
        } catch (e) {
          emit(ProvinceHandleErrorState());
        }
      },
    );
    on<ProvinceCitySearchEvent>(
      (event, emit) async {
        try {
          var cities = await repository.provicesCities(event.city);

          emit(ProvinceCitiesSuccessResponse(cities));
        } catch (e) {
          emit(ProvinceHandleErrorState());
        }
      },
    );
  }
}
