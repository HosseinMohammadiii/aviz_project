import 'dart:async';

import 'package:aviz_project/DataFuture/province/Bloc/province_event.dart';
import 'package:aviz_project/widgets/display_error.dart';
import 'package:aviz_project/widgets/provinceandcitiesitems_widget.dart';
import 'package:aviz_project/widgets/provinceandcity_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/province/Bloc/province_bloc.dart';
import '../DataFuture/province/Bloc/province_state.dart';
import '../DataFuture/province/model/province.dart';
import '../class/colors.dart';
import '../widgets/provinceandcity_appbar.dart';
import '../widgets/selectprovincebutton_widget.dart';

// ignore: must_be_immutable
class CityScreen extends StatefulWidget {
  CityScreen({
    super.key,
    required this.onChanged,
    required this.province,
  });
  String province;
  Function() onChanged;

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController citiesController = TextEditingController();

  final FocusNode citiesFocusNode = FocusNode();

  String city = '';

  bool isSelectProvinces = false;
  bool isSearch = false;

  List<ProvinceModel>? cities;
  List<ProvinceModel> searchCities = [];

  Timer? _debounce;

  @override
  void initState() {
    BlocProvider.of<ProvinceBloc>(context)
        .add(ProvinceInitializedData(city: widget.province));

    city = widget.province;
    super.initState();
  }

  void searchListItems(String value) {
    // Filter provinces based on search input
    setState(() {
      value.isEmpty ? isSearch = false : isSearch = true;
    });

    searchCities = cities!
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    // Toggle selection if the search result exactly matches a province
    if (searchCities.length == 1 && searchCities.first.name == value) {
      isSelectProvinces = true;
    } else {
      isSelectProvinces = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: AppProvinceSection(
            province: 'شهر',
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProvinceBloc, ProvinceState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ProvinceAndCityTextFeild(
                        controller: citiesController,
                        focusNode: citiesFocusNode,
                        hint: 'نام شهر خود را وارد کنید',
                        lable: 'شهر',
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) {
                            _debounce!.cancel();
                          }
                          _debounce = Timer(
                            const Duration(milliseconds: 500),
                            () {
                              if (value.endsWith('ی') || value.endsWith('ک')) {
                                value = value
                                    .replaceAll('ي', 'ی')
                                    .replaceAll('ك', 'ک');
                              } else {
                                value = value
                                    .replaceAll('ی', 'ي')
                                    .replaceAll('ک', 'ك');
                              }

                              searchListItems(value);
                            },
                          );
                        },
                      ),
                    ),
                    if (state is ProvinceLoadindState) ...[
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: CustomColor.normalRed,
                          ),
                        ),
                      ),
                    ],
                    if (state is ProvinceRsultSuccessResponse) ...[
                      SliverToBoxAdapter(
                        child: Visibility(
                          visible: !isSearch,
                          child: Column(
                            children: [
                              InkWell(
                                splashColor: CustomColor.grey350,
                                onTap: () {
                                  final cityName =
                                      context.read<RegisterInfoAdCubit>().state;
                                  setState(() {
                                    isSelectProvinces = true;
                                    cityName.city = '';
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'تمام شهر های $city',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 18,
                                        color: CustomColor.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  thickness: 1,
                                  height: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      state.city.fold(
                        (error) => DisplayError(error: error),
                        (city) {
                          cities = city;
                          return SliverPadding(
                            padding: const EdgeInsets.only(bottom: 80),
                            sliver: SliverList.builder(
                              itemCount:
                                  isSearch ? searchCities.length : city.length,
                              itemBuilder: (context, index) {
                                return ProvinceAndCitiesWidget(
                                  province: isSearch ? searchCities : city,
                                  index: index,
                                  onTap: () {
                                    setState(() {
                                      isSelectProvinces = true;
                                      final cityName = context
                                          .read<RegisterInfoAdCubit>()
                                          .state;

                                      citiesController.text = isSearch
                                          ? searchCities[index].name
                                          : city[index].name;
                                      cityName.city = citiesController.text;
                                    });
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
                SelectProvinceAndCityButton(
                  isSelectProvinces: isSelectProvinces,
                  onChanges: () {
                    widget.onChanged();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
