import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../class/colors.dart';

// ignore: must_be_immutable
class SearchProvincesScreen extends StatefulWidget {
  SearchProvincesScreen({
    super.key,
    this.isTurn = false,
  });
  bool isTurn;

  @override
  State<SearchProvincesScreen> createState() => _SearchProvincesScreenState();
}

class _SearchProvincesScreenState extends State<SearchProvincesScreen> {
  final TextEditingController provincesController = TextEditingController();

  final FocusNode provincesFocusNode = FocusNode();

  bool isSearchList = false;
  bool isSelectProvinces = false;

  List<String> searchList = [];

  List<String> provinces = [
    "آذربایجان شرقی",
    "آذربایجان غربی",
    "اردبیل",
    "اصفهان",
    "البرز",
    "ایلام",
    "بوشهر",
    "تهران",
    "چهارمحال و بختیاری",
    "خراسان جنوبی",
    "خراسان رضوی",
    "خراسان شمالی",
    "خوزستان",
    "زنجان",
    "سمنان",
    "سیستان و بلوچستان",
    "فارس",
    "قزوین",
    "قم",
    "کردستان",
    "کرمان",
    "کرمانشاه",
    "کهگیلویه وبویراحمد",
    "گلستان",
    "گیلان",
    "لرستان",
    "مازندران",
    "مرکزی",
    "هرمزگان",
    "همدان",
    "یزد"
  ];

  void searchListItems(String value) {
    List<String> searchProvinces = [];

    // Reset the list when the search field is empty
    if (value.isEmpty) {
      setState(() {});
      List<String> updatedList = provinces.toList();
      setState(() {
        searchList = updatedList;
        isSearchList = false; // No search active
      });
      FocusScope.of(context).unfocus(); // Unfocus the text field
      return;
    }

    // Filter provinces based on search input
    searchProvinces = provinces
        .where((element) => element.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      searchList = searchProvinces;
      isSearchList = true; // Search is active
    });

    // Toggle selection if the search result exactly matches a province
    if (searchProvinces.length == 1 && searchProvinces.first == value) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Text(
                'استان',
                style: TextStyle(
                  fontSize: 17,
                  color: CustomColor.black,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
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
                          labelText: 'استان',
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
                          searchListItems(value);
                          if (value.isEmpty) {
                            provincesFocusNode.requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    // Display search results or full list
                    itemCount:
                        isSearchList ? searchList.length : provinces.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 80),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var search = isSearchList
                          ? searchList.toList()[index]
                          : provinces.toList()[index];
                      return Column(
                        children: [
                          InkWell(
                            splashColor: CustomColor.grey350,
                            onTap: () {
                              // Update text field with selected province
                              provincesController.text = search;
                              setState(() {
                                // Set selection status to true
                                isSelectProvinces = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    search,
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
                    },
                  ),
                ),
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
                  if (!widget.isTurn && isSelectProvinces) {
                    context.read<AuthAccountBloc>().add(
                          UpdateProvinceUserEvent(
                            provincesController.text,
                          ),
                        );
                    Navigator.pop(context);
                  } else {}
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
    );
  }
}
