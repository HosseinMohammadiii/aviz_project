import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

class UserAccountInfirmation extends StatefulWidget {
  const UserAccountInfirmation({super.key});

  @override
  State<UserAccountInfirmation> createState() => _UserAccountInfirmationState();
}

class _UserAccountInfirmationState extends State<UserAccountInfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        height: 80,
                        width: 80,
                        color: CustomColor.pink,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 165,
                      child: Icon(Icons.camera_alt),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),
            const SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: CustomColor.red,
                  ),
                  Text(
                    'Hossein',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
