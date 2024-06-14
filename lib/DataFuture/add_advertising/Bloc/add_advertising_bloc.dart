import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/category_advertising_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdvertisingBloc
    extends Bloc<AddAdvertisingEvent, AddAdvertisingState> {
  final ICategoryAdvertisingRepository repository;
  AddAdvertisingBloc(this.repository) : super(AddAdvertisingInitializedData()) {
    on<AddAdvertisingGetInitializeData>(
      (event, emit) async {
        emit(AddAdvertisingLoading());
        var addCategory = await repository.getCategoryAdvertising();
        emit(AddAdvertisingResponse(addCategory));
      },
    );
  }
}
