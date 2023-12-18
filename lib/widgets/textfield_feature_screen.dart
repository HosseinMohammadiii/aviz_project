import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

class TextfieldFeature extends StatefulWidget {
  TextfieldFeature({
    super.key,
    required this.controller,
  });
  TextEditingController controller = TextEditingController();

  @override
  State<TextfieldFeature> createState() => _TextfieldFeatureState();
}

class _TextfieldFeatureState extends State<TextfieldFeature> {
  FocusNode focusNode = FocusNode();

  num valu = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 159,
        height: 48,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[350],
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
                      valu++;
                      widget.controller.text = valu.toString();
                    });
                  },
                  child: const Icon(
                    Icons.arrow_drop_up_rounded,
                    color: CustomColor.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (valu.toDouble() <= 0 || valu.toInt() <= 0) {
                      valu = 0;
                    } else {
                      setState(() {
                        valu--;
                        widget.controller.text = valu.toString();
                      });
                    }
                  },
                  child: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: CustomColor.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 110,
              child: TextField(
                keyboardType: TextInputType.number,
                focusNode: focusNode,
                controller: widget.controller,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontFamily: 'SN',
                  fontSize: 16,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      valu = num.tryParse(value) ?? 0;
                      widget.controller.text = valu.toString();
                    });
                  } else {
                    value = '';
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
