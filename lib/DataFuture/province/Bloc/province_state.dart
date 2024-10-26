import 'package:aviz_project/DataFuture/province/model/province.dart';
import 'package:dartz/dartz.dart';

abstract class ProvinceState {}

final class ProvinceinitializedState extends ProvinceState {}

final class ProvinceLoadindState extends ProvinceState {}

final class ProvinceRsultSuccessResponse extends ProvinceState {
  Either<String, List<ProvinceModel>> province;
  Either<String, List<ProvinceModel>> city;

  ProvinceRsultSuccessResponse(this.province, this.city);
}

final class ProvinceSuccessResponse extends ProvinceState {
  Either<String, List<ProvinceModel>> province;
  Either<String, List<ProvinceModel>> city;
  ProvinceSuccessResponse(this.province, this.city);
}

final class ProvinceCitiesSuccessResponse extends ProvinceState {
  Either<String, List<ProvinceModel>> city;
  ProvinceCitiesSuccessResponse(this.city);
}
