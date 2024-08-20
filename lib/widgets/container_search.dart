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
    required this.textEditingController,
    required this.focusNode,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  State<ContainerSearch> createState() => _ContainerSearchState();
}

class _ContainerSearchState extends State<ContainerSearch> {
  get ui => null;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(
      SearchWithQueryData(query: widget.textEditingController.text),
    );
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
            controller: widget.textEditingController,
            autofocus: true,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.end,
            textInputAction: TextInputAction.search,
            textDirection: ui?.TextDirection.ltr,
            textAlignVertical: TextAlignVertical.center,
            focusNode: widget.focusNode,
            style: TextStyle(
              fontFamily: 'SN',
              fontSize: 18,
              color: CustomColor.grey500,
            ),
            decoration: InputDecoration(
              suffixIcon: Image.asset('images/search-normal.png'),
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
              hintText: '...جستوجو',
              hintStyle: TextStyle(
                fontFamily: 'SN',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: CustomColor.grey500,
              ),
            ),
            onTapOutside: (event) {
              widget.focusNode.unfocus();
            },
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchWithQueryData(query: value));
            },
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
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
                    (search) => SliverList.builder(
                      itemCount: search.length,
                      itemBuilder: (context, index) {
                        return AdvertisingSearchWidget(
                            advertisingHome: search[index]);
                      },
                    ),
                  )
                ],
                if (state is SearchLoadingState) ...[
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
