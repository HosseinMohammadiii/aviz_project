import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../class/checkconnection.dart';
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
    return BlocBuilder<AuthAccountBloc, AuthAccountState>(
      builder: (context, state) {
        return Container(
          height: 95,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.grey350),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state is DisplayInformationState) ...[
                state.displayUserInformation.fold(
                  (error) {
                    return Text(error);
                  },
                  (userInfo) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (!await checkInternetConnection(
                                        context)) {
                                      return;
                                    }
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
                                  userInfo.name,
                                  CustomColor.black,
                                  16,
                                  FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: RegisterId().getPhoneNumber().isNotEmpty,
                            replacement: Container(
                              height: 30,
                              width: 66,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: CustomColor.red,
                              ),
                              child: textWidget(
                                'تایید نشده',
                                CustomColor.grey,
                                12,
                                FontWeight.w500,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 30,
                                  width: 66,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
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
                                  userInfo.phoneNumber != 0
                                      ? userInfo.phoneNumber.toString()
                                      : 'وارد نشده',
                                  userInfo.phoneNumber != 0
                                      ? CustomColor.black
                                      : CustomColor.grey500,
                                  16,
                                  FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              if (state is DisplayInformationState) ...[
                state.displayUserInformation.fold(
                  (l) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'images/user_profile.png',
                        scale: 7,
                      ),
                    ),
                  ),
                  (userInfo) => userInfo.avatar.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 70,
                                child: CachedNetworkImage(
                                  imageUrl: userInfo.avatar,
                                  height: 107,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Center(
                                    child: Image.asset(
                                      'images/user_profile.png',
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: Shimmer.fromColors(
                                      baseColor: const Color(0xffE1E1E1),
                                      highlightColor: const Color(0xffF3F3F2),
                                      child: const Center(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'images/user_profile.png',
                            height: 70,
                          ),
                        ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
