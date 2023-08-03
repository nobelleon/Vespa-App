import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:vespa_app/utils/sized_config.dart';

class ProfilePicWidget extends StatefulWidget {
  const ProfilePicWidget({Key key}) : super(key: key);

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AvatarGlow(
          glowColor: Colors.purple,
          endRadius: 120,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          curve: Curves.easeOutQuad,
          child: Container(
            height: SizedConfig.heightMultiplier * 15,
            width: SizedConfig.widthMultiplier * 35,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/Vespa delivery.jpg"),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
      ),
    );
  }
}
