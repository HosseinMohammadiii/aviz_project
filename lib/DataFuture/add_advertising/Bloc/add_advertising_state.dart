import 'package:aviz_project/DataFuture/add_advertising/Data/model/category_advertising.dart';
import 'package:dartz/dartz.dart';

abstract class AddAdvertisingState {}

final class AddAdvertisingInitializedData extends AddAdvertisingState {}

final class AddAdvertisingLoading extends AddAdvertisingState {}

final class AddAdvertisingResponse extends AddAdvertisingState {
  Either<String, List<CategoryAdvertising>> categoryAdvertising;
  AddAdvertisingResponse(this.categoryAdvertising);
}
