import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Liked extends StatelessWidget {
  const Liked({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/balloon.svg',
          color: Colors.grey,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
