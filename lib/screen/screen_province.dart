import 'dart:async';

import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_bloc.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_state.dart';
import 'package:aviz_project/DataFuture/province/model/province.dart';
import 'package:aviz_project/widgets/display_error.dart';
import 'package:aviz_project/widgets/provinceandcitiesitems_widget.dart';
import 'package:aviz_project/widgets/provinceandcity_appbar.dart';
import 'package:aviz_project/widgets/provinceandcity_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/selectprovincebutton_widget.dart';

// ignore: must_be_immutable
class ScreenProvince extends StatefulWidget {
  ScreenProvince({
    super.key,
    required this.onChanged,
    this.isCity,
    this.onChangedCity,
  });
  bool? isCity;
  Function() onChanged;
  Function()? onChangedCity;
  @override
  State<ScreenProvince> createState() => _ScreenProvinceState();
}

class _ScreenProvinceState extends State<ScreenProvince> {
  final TextEditingController provincesController = TextEditingController();

  final FocusNode provincesFocusNode = FocusNode();

  bool isSelectProvinces = false;
  bool isSearch = false;

  List<ProvinceModel>? provinces;
  List<ProvinceModel> searchProvinces = [];

  Timer? _debounce;

  void searchListItems(String value) {
    // Filter provinces based on search input
    setState(() {
      value.isEmpty ? isSearch = false : isSearch = true;
    });

    searchProvinces = provinces!
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    // Toggle selection if the search result exactly matches a province
    if (searchProvinces.length == 1 && searchProvinces.first.name == value) {
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
            province: 'استان',
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProvinceBloc, ProvinceState>(
          builder: (context, state) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ProvinceAndCityTextFeild(
                      controller: provincesController,
                      focusNode: provincesFocusNode,
                      hint: 'نام استان خود را وارد کنید',
                      lable: 'استان',
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            if (value.endsWith('ی')) {
                              value = value.replaceAll('ي', 'ی');
                            } else {
                              value = value.replaceAll('ی', 'ي');
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
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  if (state is ProvinceRsultSuccessResponse) ...[
                    state.province.fold(
                      (error) => DisplayError(error: error),
                      (province) {
                        provinces = province;

                        return SliverToBoxAdapter(
                          child: ListView.builder(
                            itemCount: isSearch
                                ? searchProvinces.length
                                : provinces!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 80),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final provinceName =
                                  context.read<RegisterInfoAdCubit>().state;

                              return ProvinceAndCitiesWidget(
                                province: isSearch ? searchProvinces : province,
                                index: index,
                                onTap: () {
                                  setState(() {
                                    isSelectProvinces = true;

                                    provincesController.text = isSearch
                                        ? searchProvinces[index].name
                                        : province[index].name;
                                    provinceName.province =
                                        provincesController.text;
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
                  if (widget.isCity != null && widget.isCity == true) {
                    widget.onChangedCity!();
                  }
                  widget.onChanged();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
