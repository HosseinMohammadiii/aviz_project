import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_event.dart';
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
        flexibleSpace: BlocBuilder<PageNumberBloc, PageNumberState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<PageNumberBloc>(context)
                            .add(minusPageNumber());
                      },
                      child: Image.asset(
                        'images/close-square.png',
                        scale: 0.7,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Image.asset(state.pageNumber == 5
                          ? 'images/register_aviz.png'
                          : 'images/appbar_image_add_dvertising_screen.png'),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<PageNumberBloc>(context)
                            .add(addPageNumber());
                      },
                      child: Image.asset(
                        'images/arrow-right.png',
                        scale: 0.7,
                      ),
                    ),
                  ],
                ),
                StepProgressIndicator(
                  totalSteps: 5,
                  currentStep: state.pageNumber,
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
}
