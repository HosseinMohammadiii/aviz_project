import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_event.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_state.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class/colors.dart';
import '../widgets/text_widget.dart';

class RecentUserAdItems extends StatefulWidget {
  const RecentUserAdItems({super.key});

  @override
  State<RecentUserAdItems> createState() => _RecentUserAdItemsState();
}

class _RecentUserAdItemsState extends State<RecentUserAdItems> {
  @override
  void initState() {
    context.read<RecentBloc>().add(GetInitializedDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              const Spacer(),
              const Expanded(
                flex: 2,
                child: Text(
                  'آگهی های بازید شده',
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomColor.red,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<RecentBloc, RecentState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RecentBloc>().add(GetInitializedDataEvent());
              },
              child: CustomScrollView(
                slivers: [
                  if (state is RecentLoadingState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  if (state is GetRecentState) ...[
                    state.getDisplayAd.fold(
                      (error) => SliverToBoxAdapter(
                        child: Center(
                          child: textWidget(
                            error,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      (ad) => state.getRecentAd.fold(
                        (error) => SliverToBoxAdapter(
                          child: Center(
                            child: textWidget(
                              error,
                              CustomColor.black,
                              16,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        (recent) => state.advertisingFacilitiesDetails.fold(
                          (error) => SliverToBoxAdapter(
                            child: Center(
                              child: textWidget(
                                error,
                                CustomColor.black,
                                16,
                                FontWeight.w500,
                              ),
                            ),
                          ),
                          (facilities) => state.advertisingGalleryDetails.fold(
                            (error) => SliverToBoxAdapter(
                              child: Center(
                                child: textWidget(
                                  error,
                                  CustomColor.black,
                                  16,
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                            (adGallery) => recent.isNotEmpty
                                ? SliverList.builder(
                                    itemCount: recent.length,
                                    itemBuilder: (context, index) {
                                      var advertisingFacilities =
                                          facilities.toList()[index];

                                      var recentAd = recent.toList()[index];

                                      var recentadd = ad
                                          .where((item) =>
                                              item.id == recentAd.idAd)
                                          .toList();

                                      var gallery = adGallery
                                          .where((item) =>
                                              item.id == recentadd[0].idGallery)
                                          .toList();
                                      return AdvertisingWidget(
                                        advertising: recentadd[0],
                                        advertisingFacilities:
                                            advertisingFacilities,
                                        advertisingImages: gallery[0].images[0],
                                        isDelete: false,
                                      );
                                    },
                                  )
                                : const SliverFillRemaining(
                                    child: Center(
                                      child: Text(
                                        '!هنوز از آگهی بازدید نکردی که',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
