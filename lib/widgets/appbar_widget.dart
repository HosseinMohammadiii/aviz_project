import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({
    super.key,
    required this.stepScreen,
  });
  int stepScreen;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.close_rounded,
                  size: 35,
                ),
                Image.asset(widget.stepScreen == 5
                    ? 'images/register_aviz.png'
                    : 'images/appbar_image_add_dvertising_screen.png'),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.stepScreen++;
                    });
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
              unselectedColor: Colors.white,
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
