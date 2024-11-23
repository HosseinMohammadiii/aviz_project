import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_bloc.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_state.dart';
import 'package:aviz_project/screen/info_myad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/advertising_save/bloc/advertising_save_event.dart';
import '../class/colors.dart';
import '../widgets/advertising_widget.dart';
import '../widgets/displayreconnection.dart';

class DisplayAdSaveItems extends StatefulWidget with RouteAware {
  const DisplayAdSaveItems({super.key});

  @override
  State<DisplayAdSaveItems> createState() => _DisplayAdSaveItemsState();
}

class _DisplayAdSaveItemsState extends State<DisplayAdSaveItems>
    with RouteAware {
  @override
  void initState() {
    context.read<SaveAdBloc>().add(GetInitializedSaveDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'آگهی های ذخیره شده',
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
        child: BlocBuilder<SaveAdBloc, SaveAdState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: CustomColor.normalRed,
              onRefresh: () async {
                context.read<SaveAdBloc>().add(GetInitializedSaveDataEvent());
              },
              child: CustomScrollView(
                slivers: [
                  if (state is SaveLoadingState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.normalRed,
                        ),
                      ),
                    ),
                  ],
                  if (state is GetSaveState) ...[
                    state.getDisplayAd.fold(
                      (error) => DisplayReconnection(screen: 'ذخیره شده ها'),
                      (ad) => state.advertisingFacilitiesDetails.fold(
                        (error) => DisplayReconnection(screen: 'ذخیره شده ها'),
                        (facilities) => state.getSaveAd.fold(
                          (error) =>
                              DisplayReconnection(screen: 'ذخیره شده ها'),
                          (saveAd) => saveAd.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: saveAd.length,
                                  itemBuilder: (context, index) {
                                    var saveAdvertising =
                                        saveAd.toList()[index];

                                    var savedAd = ad.firstWhere(
                                      (item) => item.id == saveAdvertising.idAd,
                                    );

                                    var advertisingFacilities =
                                        facilities.firstWhere(
                                      (item) => item.id == savedAd.idFacilities,
                                    );

                                    return AdvertisingWidget(
                                      advertising: savedAd,
                                      advertisingFacilities:
                                          advertisingFacilities,
                                      advertisingImages: savedAd.images[0],
                                      screen: InformatioMyAdvertising(
                                        isDelete: false,
                                        advertisingHome: savedAd,
                                      ),
                                    );
                                  },
                                )
                              : const SliverFillRemaining(
                                  child: Center(
                                    child: Text(
                                      '!هنوز آگهی ذخیره نکردی که',
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
