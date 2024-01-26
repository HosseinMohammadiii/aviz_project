import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({
    super.key,
    required this.stepScreen,
    required this.screen,
    this.dialog = '',
  });
  int stepScreen;
  Widget screen;

  String dialog;
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
        flexibleSpace: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.stepScreen == 1 ? Null : Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(widget.stepScreen == 5
                      ? 'images/register_aviz.png'
                      : 'images/appbar_image_add_dvertising_screen.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.screen,
                        ));
                  },
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 45,
                  ),
                ),
              ],
            ),
            StepProgressIndicator(
              totalSteps: 5,
              currentStep: widget.stepScreen,
              unselectedColor: CustomColor.white,
              selectedColor: CustomColor.red,
              padding: 0,
              progressDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
