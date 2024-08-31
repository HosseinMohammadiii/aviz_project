import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../screen/user_account_informatio.dart';

class InfoAccountUser extends StatefulWidget {
  const InfoAccountUser({
    super.key,
  });

  @override
  State<InfoAccountUser> createState() => _InfoAccountUserState();
}

class _InfoAccountUserState extends State<InfoAccountUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UserAccountInfirmation(),
                            ),
                          );
                        },
                        child: Image.asset('images/edit.png'),
                      ),
                      textWidget(
                        'حسین محمدی',
                        CustomColor.black,
                        16,
                        FontWeight.w700,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 66,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: CustomColor.red,
                        ),
                        child: textWidget(
                          'تایید شده',
                          CustomColor.grey,
                          14,
                          FontWeight.w500,
                        ),
                      ),
                      textWidget(
                        '..71...0913',
                        CustomColor.black,
                        16,
                        FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('images/me.jpeg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
