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
          horizontal: (MediaQuery.of(context).size.width * 0.15), vertical: 10),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < bottomActionBarItems.length; i++)
              InkWell(
                splashColor: Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                onTap: () => onTap(i),
                child: bottomActionBarItems[i],
              )
          ],
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
