import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Bloc/bloc_page_number/page_n_bloc_state.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: double.infinity,
        leading: BlocBuilder<NavigationPage, NavigationState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Visibility.maintain(
                      visible: ViewPage.category != state.viewPage,
                      child: GestureDetector(
                        onTap: () {
                          switch (state.viewPage) {
                            //Switching the status when we are on the items category page.
                            case ViewPage.category:
                              break;

                            //Switching the status when we are on the ad items category page to a category step.
                            case ViewPage.itemsRentHome:
                            case ViewPage.itemsBuyHome:
                              context
                                  .read<NavigationPage>()
                                  .getNavItems(ViewPage.category);
                              break;

                            //Switching the status when we are on the ad information registration page to a previous step.
                            case ViewPage.registerDetialsRentHomeAdvertising:
                              context
                                  .read<NavigationPage>()
                                  .getNavItems(ViewPage.itemsRentHome);

                              context
                                  .read<RegisterInfoAdCubit>()
                                  .resetInfoAdSet();
                              context.read<BoolStateCubit>().reset();
                              break;
                            case ViewPage.registerDetialsBuyHomeAdvertising:
                              context.read<AddAdvertisingBloc>().add(
                                    DeleteFacilitiesData(
                                        idAdFacilities:
                                            RegisterId().getIdFacilities()),
                                  );
                              context
                                  .read<NavigationPage>()
                                  .getNavItems(ViewPage.itemsBuyHome);
                              context
                                  .read<RegisterInfoAdCubit>()
                                  .resetInfoAdSet();
                              context.read<BoolStateCubit>().reset();
                              break;

                            //Switching the status when we are on the ad final information registration page to a previous step.
                            case ViewPage.registerHomeAdvertising:
                              context.read<NavigationPage>().getNavItems(
                                  ViewPage.registerDetialsBuyHomeAdvertising);
                              context.read<BoolStateCubit>().state.isUpdate =
                                  true;

                              break;

                            case ViewPage.registerRentHomeAdvertising:
                              context.read<NavigationPage>().getNavItems(
                                  ViewPage.registerDetialsRentHomeAdvertising);
                              context.read<BoolStateCubit>().state.isUpdate =
                                  true;

                              break;

                            //Switching the status when we are not in a stage.
                            default:
                              context
                                  .read<NavigationPage>()
                                  .getNavItems(ViewPage.category);
                              break;
                          }
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          size: 35,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      //  height: 35,
                      child: Image.asset(
                        state.viewPage == ViewPage.registerHomeAdvertising
                            ? 'images/register_aviz.png'
                            : 'images/appbar_image_add_dvertising_screen.png',
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Spacer(),
                  ],
                ),
                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: indexItem(state.viewPage),
                  unselectedColor: CustomColor.white,
                  selectedColor: CustomColor.red,
                  padding: 0,
                  progressDirection: TextDirection.rtl,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  //Function Calculate Step For StepProgressIndicator Widget.
  int indexItem(ViewPage v) {
    int index = 1;
    switch (v) {
      case ViewPage.category:
        index = 1;
        break;

      case ViewPage.itemsRentHome:
      case ViewPage.itemsBuyHome:
        index = 2;
        break;

      case ViewPage.registerDetialsRentHomeAdvertising:
      case ViewPage.registerDetialsBuyHomeAdvertising:
        index = 3;
        break;

      case ViewPage.registerHomeAdvertising:
      case ViewPage.registerRentHomeAdvertising:
        index = 4;
        break;

      default:
        index = 1;
        break;
    }
    return index;
  }
}
