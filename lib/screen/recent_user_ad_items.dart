import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_event.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_state.dart';
import 'package:aviz_project/screen/info_myad.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class/colors.dart';
import '../widgets/displayreconnection.dart';

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
        title: const Text(
          'آگهی های بازدید شده',
          style: TextStyle(
            fontSize: 18,
            color: CustomColor.red,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<RecentBloc, RecentState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: CustomColor.normalRed,
              onRefresh: () async {
                context.read<RecentBloc>().add(GetInitializedDataEvent());
              },
              child: CustomScrollView(
                slivers: [
                  if (state is RecentLoadingState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.normalRed,
                        ),
                      ),
                    ),
                  ],
                  if (state is GetRecentState) ...[
                    state.getDisplayAd.fold(
                      (error) => DisplayReconnection(screen: 'بازدید های اخیر'),
                      (advertising) => state.getRecentAd.fold(
                        (error) =>
                            DisplayReconnection(screen: 'بازدید های اخیر'),
                        (recent) => state.advertisingFacilitiesDetails.fold(
                          (error) =>
                              DisplayReconnection(screen: 'بازدید های اخیر'),
                          (facilities) => recent.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: recent.length,
                                  itemBuilder: (context, index) {
                                    var recentAd = advertising.firstWhere(
                                      (item) => item.id == recent[index].idAd,
                                    );
                                    var advertisingFacilities = facilities
                                        .where(
                                          (item) =>
                                              item.id == recentAd.idFacilities,
                                        )
                                        .toList();

                                    return AdvertisingWidget(
                                      advertising: recentAd,
                                      advertisingFacilities:
                                          advertisingFacilities[0],
                                      advertisingImages: recentAd.images[0],
                                      screen: InformatioMyAdvertising(
                                        isDelete: false,
                                        advertisingHome: recentAd,
                                      ),
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
