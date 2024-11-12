import 'dart:async';

import 'package:aviz_project/screen/info_myad.dart';
import 'package:aviz_project/widgets/advertising_box.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/search/Bloc/search_bloc.dart';
import '../DataFuture/search/Bloc/search_event.dart';
import '../DataFuture/search/Bloc/search_state.dart';
import '../class/colors.dart';

class ContainerSearch extends StatefulWidget {
  const ContainerSearch({
    super.key,
  });

  @override
  State<ContainerSearch> createState() => _ContainerSearchState();
}

class _ContainerSearchState extends State<ContainerSearch> {
  get ui => null;

  Timer? _debounce;
  @override
  void initState() {
    context.read<SearchBloc>().add(SearchWithQueryData(query: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.1,
        backgroundColor: CustomColor.grey,
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.end,
            textInputAction: TextInputAction.search,
            textDirection: ui?.TextDirection.ltr,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontFamily: 'SN',
              fontSize: 18,
              color: CustomColor.grey500,
            ),
            decoration: InputDecoration(
              suffixIcon: Image.asset(
                'images/search_icon.png',
                scale: 2.5,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColor.grey350,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColor.grey350,
                ),
              ),
              hintText: 'جستوجو',
              hintStyle: TextStyle(
                fontFamily: 'SN',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: CustomColor.grey500,
              ),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context
                    .read<SearchBloc>()
                    .add(SearchWithQueryData(query: value));
              });
            },
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is SearchLoadingState) ...[
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: CustomColor.normalRed,
                      ),
                    ),
                  ),
                ],
                if (state is SearchRequestSuccessState) ...[
                  state.searchResult.fold(
                    (l) => SliverToBoxAdapter(
                      child: Center(
                        child: textWidget(
                          l,
                          CustomColor.black,
                          16,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    (adHome) {
                      return Visibility(
                        visible: adHome.isNotEmpty,
                        replacement: const SliverFillRemaining(
                          child: Center(
                            child: Text(
                              '.نتیجه ای یافت نشد',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: CustomColor.black,
                              ),
                            ),
                          ),
                        ),
                        child: SliverList.builder(
                          itemCount: adHome.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InformatioMyAdvertising(
                                        advertisingHome: adHome[index],
                                        isDelete: false,
                                      ),
                                    ));
                              },
                              child: AdvertisingSearchWidget(
                                advertisingHome: adHome[index],
                                adGallery: adHome[index].images[0],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
