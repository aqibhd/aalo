import 'package:flutter/material.dart';

class OverlayAppBar extends StatelessWidget {
  const OverlayAppBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0 + (MediaQuery.of(context).padding.top),
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.only(
            top: (MediaQuery.of(context).padding.top),
          ),
          child: child),
    );
  }
}
