import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Bloc/bloc_page_number/page_n_bloc_state.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: BlocBuilder<NavigationPage, NavigationState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        switch (state.viewPage) {
                          //Switching the status when we are on the items category page.
                          case ViewPage.category:
                            break;

                          //Switching the status when we are on the ad items category page to a category step.
                          case ViewPage.itemsRentHome:
                          case ViewPage.itemsBuyHome:
                          case ViewPage.itemsBuyBusinessPlace:
                          case ViewPage.itemsRentBusinessPlace:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.category);
                            break;

                          //Switching the status when we are on the ad information registration page to a previous step.
                          case ViewPage.registerDetialsRentHomeAdvertising:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.itemsRentHome);
                            break;
                          case ViewPage.registerDetialsBuyHomeAdvertising:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.itemsBuyHome);
                            break;

                          //Switching the status when we are on the ad location registration page to a previous step.
                          case ViewPage.registerHomeLocation:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(
                                    ViewPage.registerDetialsBuyHomeAdvertising);
                            break;

                          case ViewPage.registerBusinessLocation:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.itemsRentBusinessPlace);
                            break;

                          //Switching the status when we are on the ad final information registration page to a previous step.
                          case ViewPage.registerHomeAdvertising:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(
                                    ViewPage.registerDetialsBuyHomeAdvertising);
                            break;

                          case ViewPage.registerBusinessAdvertising:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.registerBusinessLocation);
                            break;

                          //Switching the status when we are not in a stage.
                          default:
                            BlocProvider.of<NavigationPage>(context)
                                .getNavItems(ViewPage.category);
                            break;
                        }
                      },
                      child: state.viewPage == ViewPage.category
                          ? const SizedBox()
                          : const Icon(
                              Icons.close_rounded,
                              size: 35,
                            ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 35,
                      child: Image.asset(
                        state.viewPage == ViewPage.itemsBuyBusinessPlace
                            ? 'images/register_aviz.png'
                            : 'images/appbar_image_add_dvertising_screen.png',
                      ),
                    ),
                    const SizedBox(
                      width: 105,
                    ),
                  ],
                ),
                StepProgressIndicator(
                  totalSteps: 5,
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

      case ViewPage.itemsRentBusinessPlace:
      case ViewPage.itemsBuyBusinessPlace:
      case ViewPage.registerDetialsRentHomeAdvertising:
      case ViewPage.registerDetialsBuyHomeAdvertising:
        index = 3;
        break;

      case ViewPage.registerHomeLocation:
      case ViewPage.registerBusinessLocation:
        index = 4;
        break;
      case ViewPage.registerHomeAdvertising:
      case ViewPage.registerBusinessAdvertising:
        index = 5;
        break;

      default:
        index = 1;
        break;
    }
    return index;
  }
}
