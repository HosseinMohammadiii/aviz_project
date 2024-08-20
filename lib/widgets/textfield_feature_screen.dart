import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

class TextfieldFeature extends StatefulWidget {
  TextfieldFeature({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.value,
  });
  TextEditingController controller = TextEditingController();
  TextInputAction textInputAction;
  num value = 0;
  @override
  State<TextfieldFeature> createState() => _TextfieldFeatureState();
}

class _TextfieldFeatureState extends State<TextfieldFeature> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 159,
        height: 48,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: CustomColor.grey350,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.value++;
                      widget.controller.text = widget.value.toString();
                    });
                  },
                  child: const Icon(
                    Icons.arrow_drop_up_rounded,
                    color: CustomColor.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.value <= 0 || widget.controller.text == '1340') {
                      return;
                    }
                    setState(() {
                      widget.value--;
                      widget.controller.text =
                          widget.value == 0 ? '' : widget.value.toString();
                    });
                  },
                  child: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: CustomColor.red,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 110,
              child: TextField(
                keyboardType: TextInputType.number,
                focusNode: focusNode,
                controller: widget.controller,
                textInputAction: widget.textInputAction,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontFamily: 'SN',
                  fontSize: 16,
                  color: CustomColor.black,
                  overflow: TextOverflow.ellipsis,
                ),
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      widget.value = num.tryParse(val) ?? 0;
                      widget.controller.text = widget.value.toString();
                    });
                  } else {
                    val = '';
                    widget.value = 0;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
