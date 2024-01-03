import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SwitchBox extends StatefulWidget {
  SwitchBox({super.key, required this.switchCheck, required this.txt});
  bool switchCheck;
  String txt;

  @override
  State<SwitchBox> createState() => _SwitchBoxState();
}

class _SwitchBoxState extends State<SwitchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            activeColor: CustomColor.red,
            value: widget.switchCheck,
            onChanged: (value) {
              setState(() {
                widget.switchCheck = !widget.switchCheck;
                value = widget.switchCheck;
              });
            },
          ),
          textWidget(
            widget.txt,
            CustomColor.black,
            16,
            FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
