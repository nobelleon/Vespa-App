import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vespa_app/screens/CallScreen/Components/profile_pic_widget.dart';
import 'package:vespa_app/utils/sized_config.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizedConfig.heightMultiplier * 3,
            ),
            Text(
              "Hallo, \n Anda sedang berbicara dengan Joey",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizedConfig.textMultiplier * 2.5,
                color: Colors.purple,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: SizedConfig.heightMultiplier * 10,
            ),
            // getar dering
            Container(
              height: SizedConfig.heightMultiplier * 30,
              width: SizedConfig.widthMultiplier * 100,
              child: const ProfilePicWidget(),
            ),
            SizedBox(
              height: SizedConfig.heightMultiplier * 2,
            ),
            Text(
              "Joey",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizedConfig.textMultiplier * 2.5,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: SizedConfig.heightMultiplier * 2,
            ),
            const Text(
              "Berdering...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: SizedConfig.heightMultiplier * 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol tutup telpon
                GestureDetector(
                  onTap: () {
                    Get.back();
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return;
                    //     },
                    //   ),
                    // );
                  },
                  child: Container(
                    height: SizedConfig.heightMultiplier * 8,
                    width: SizedConfig.widthMultiplier * 18,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 8),
                          color: Colors.black26,
                          blurRadius: 8)
                    ], shape: BoxShape.circle, color: Colors.purple),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizedConfig.widthMultiplier * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return MessageScreen();
                    //     },
                    //   ),
                    // );
                  },
                  child: Container(
                    height: SizedConfig.heightMultiplier * 8,
                    width: SizedConfig.widthMultiplier * 18,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 8),
                          color: Colors.black26,
                          blurRadius: 8)
                    ], shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      MdiIcons.motorbikeElectric,
                      size: 29,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 0 * .15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
