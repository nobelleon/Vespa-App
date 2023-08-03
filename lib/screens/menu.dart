import 'package:flutter/material.dart';
import 'package:vespa_app/core/constants.dart';
import 'package:vespa_app/screens/CallScreen/call_screen.dart';
import 'package:vespa_app/screens/widget/map_icon.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Menu extends StatefulWidget {
  final double menuSlideOutPercent;

  const Menu({Key key, this.menuSlideOutPercent}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int currentIndex = 0;
  double itemSize = 50;

  // List<Widget> _menuItems() {
  //   return icons.map((item) {
  //     final int index = icons.indexOf(item);
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(
  //         vertical: defaultSpacing * .8,
  //         horizontal: defaultSpacing,
  //       ),
  //       child: Stack(
  //         children: [
  //           AnimatedContainer(
  //             width: itemSize,
  //             height: itemSize,
  //             duration: const Duration(milliseconds: 300),
  //             transform: Matrix4.translationValues(0, 0, 0)
  //               ..scale(
  //                 currentIndex != index ? 0.01 : 1.0,
  //               ),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(defaultSpacing),
  //               color: Colors.white.withOpacity(.3),
  //             ),
  //           ),
  //           ImageIcon(
  //             AssetImage(item),
  //             color: Colors.white,
  //           )
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          stops: <double>[0.3, 1.0],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            // left: -(itemSize + defaultSpacing) * widget.menuSlideOutPercent,
            left:
                15.0 - (itemSize + defaultSpacing) * widget.menuSlideOutPercent,
            child: Column(
              children: [
                WebsafeSvg.asset("assets/images/icon_home.svg",
                    height: 30, width: 30),
                //..._menuItems()
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.call,
                  ),
                  iconSize: 34,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CallScreen(),
                        ));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.map_outlined,
                  ),
                  iconSize: 35,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapIcon(),
                        ));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mosque,
                  ),
                  iconSize: 33,
                  color: Colors.white60,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 25,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.assistant_navigation,
                  ),
                  iconSize: 33,
                  color: Colors.white60,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 25,
                ),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  iconSize: 30,
                  color: Colors.white60,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
