import 'dart:async';

import 'package:aviz_project/DataFuture/province/Bloc/province_bloc.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_event.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_state.dart';
import 'package:aviz_project/DataFuture/province/model/province.dart';
import 'package:aviz_project/widgets/display_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_event.dart';
import '../class/colors.dart';

// ignore: must_be_immutable
class ScreenProvince extends StatefulWidget {
  ScreenProvince({super.key, required this.isCities});
  bool isCities;
  @override
  State<ScreenProvince> createState() => _ScreenProvinceState();
}

class _ScreenProvinceState extends State<ScreenProvince> {
  final TextEditingController provincesController = TextEditingController();

  final FocusNode provincesFocusNode = FocusNode();

  bool isSelectProvinces = false;
  bool showCities = false;

  List<ProvinceModel> provinces = [];

  Timer? _debounce;

  void searchListItems(String value) {
    List<ProvinceModel> searchProvinces = [];

    // Filter provinces based on search input
    searchProvinces = provinces
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
  void initState() {
    super.initState();
  }

  void managementBool() {
    setState(() {
      if (widget.isCities) {
        showCities = true;
      } else {
        showCities = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Text(
                showCities ? 'شهرها' : 'استان',
                style: const TextStyle(
                  fontSize: 17,
                  color: CustomColor.black,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  // context
                  //     .read<ProvinceBloc>()
                  //     .add(ProvinceSearchEvent(province: ""));

                  showCities
                      ? setState(() {
                          showCities = false;
                        })
                      : Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: provincesController,
                          focusNode: provincesFocusNode,
                          keyboardType: TextInputType.streetAddress,
                          autofocus: true,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'نام استان خود را وارد کنید',
                            labelText: showCities ? 'شهرها' : 'استان',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: colorShow(
                                  provincesFocusNode, provincesController),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colorShow(
                                    provincesFocusNode, provincesController),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 1,
                                color: colorShow(
                                    provincesFocusNode, provincesController),
                              ),
                            ),
                          ),
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

                                context
                                    .read<ProvinceBloc>()
                                    .add(ProvinceSearchEvent(province: value));

                                searchListItems(value);
                              },
                            );
                          },
                        ),
                      ),
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
                      (province) => state.city.fold(
                        (error) => DisplayError(error: error),
                        (cities) => SliverToBoxAdapter(
                          child: ListView.builder(
                            itemCount:
                                showCities ? cities.length : province.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 80),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              provinces = province.toList();

                              return _showProvinceAndCities(
                                context,
                                showCities ? cities : province,
                                index,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Container(
                height: 70,
                width: double.infinity,
                color: CustomColor.grey,
                alignment: Alignment.topCenter,
                transformAlignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthAccountBloc>().add(
                          UpdateProvinceUserEvent(
                            provincesController.text,
                          ),
                        );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isSelectProvinces
                          ? CustomColor.red
                          : CustomColor.grey300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'انتخاب',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showProvinceAndCities(
      BuildContext context, List<ProvinceModel> province, int index) {
    return Column(
      children: [
        InkWell(
          splashColor: CustomColor.grey350,
          onTap: () {
            setState(() {
              showCities
                  ? context
                      .read<ProvinceBloc>()
                      .add(ProvinceInitializedData(city: province[index].name))
                  : provincesController.text = province[index].name;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  showCities ? province[index].name : province[index].name,
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
    );
  }
}
