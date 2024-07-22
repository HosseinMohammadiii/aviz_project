import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../class/colors.dart';
import '../class/switch_classs.dart';
import 'text_widget.dart';

class ItemsSwitchbox extends StatefulWidget {
  ItemsSwitchbox({
    super.key,
  });
  @override
  State<ItemsSwitchbox> createState() => _ItemsSwitchboxState();
}

class _ItemsSwitchboxState extends State<ItemsSwitchbox> {
  List<ClassSwitchBox> propertiesTxt = [
    ClassSwitchBox('آسانسور', false),
    ClassSwitchBox('پارکینگ', false),
    ClassSwitchBox('انباری', false),
    ClassSwitchBox('بالکن', false),
    ClassSwitchBox('پنت هاوس', false),
  ];
  @override
  void initState() {
    // BlocProvider.of<AdFeaturesBloc>(context)
    //     .add(AdFeaturesGetInitializeData(widget.advertisingFacilities.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: propertiesTxt.length,
      itemBuilder: (context, index) => Container(
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
              activeTrackColor: CustomColor.red,
              thumbColor: const WidgetStatePropertyAll(CustomColor.grey),
              trackOutlineColor:
                  const WidgetStatePropertyAll(Colors.transparent),
              value: propertiesTxt[index].switchBool,
              onChanged: (value) {
                bool elevator = propertiesTxt[index].switchBool;
                bool parking = propertiesTxt[index].switchBool;
                bool storeroom = propertiesTxt[index].switchBool;
                bool balcony = propertiesTxt[index].switchBool;
                bool penthouse = propertiesTxt[index].switchBool;
                setState(() {
                  propertiesTxt[index].switchBool = value;
                  if (propertiesTxt[index].txt == 'آسانسور') {
                    elevator = value;
                  } else if (propertiesTxt[index].txt == 'پارکینگ') {
                    parking = value;
                  } else if (propertiesTxt[index].txt == 'انباری') {
                    storeroom = value;
                  } else if (propertiesTxt[index].txt == 'بالکن') {
                    balcony = value;
                  } else if (propertiesTxt[index].txt == 'پنت هاوس') {
                    penthouse = value;
                  }
                });
                context
                    .read<BoolStateCubit>()
                    .updateBool(propertiesTxt[index].txt, value);
              },
            ),
            textWidget(
              propertiesTxt[index].txt,
              CustomColor.black,
              16,
              FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
