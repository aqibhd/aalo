import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar(
      {super.key, required this.bottomActionBarItems, required this.onTap});
  final List<Widget> bottomActionBarItems;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width * 0.2), vertical: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 5, 5, 5).withOpacity(0.85),
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < bottomActionBarItems.length; i++)
                  InkWell(
                    enableFeedback: false,
                    splashColor: Colors.white.withOpacity(0.05),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                    onTap: () => onTap(i),
                    child: bottomActionBarItems[i],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomActionBarItem(String svgItemPath, Color itemColor) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        svgItemPath,
        height: 24,
        width: 24,
        color: itemColor,
      ),
    ),
  );
}
