import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdditionalResource extends StatelessWidget {
  const AdditionalResource({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Additional Resource",
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: const [
          AdditionalTile(
            assetPath: 'assets/svg/version.svg',
            title: "Version 1.0.2",
          ),
          AdditionalTile(
            assetPath: 'assets/svg/feedBack.svg',
            title: "Give feedback",
          ),
          AdditionalTile(
            assetPath: 'assets/svg/terms.svg',
            title: "Terms of Service",
          ),
          AdditionalTile(
            assetPath: 'assets/svg/policy.svg',
            title: "Privacy Policy",
          ),
        ],
      ),
    );
  }
}

class AdditionalTile extends StatelessWidget {
  const AdditionalTile(
      {super.key, required this.assetPath, required this.title});
  final String title, assetPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      leading: SvgPicture.asset(
        assetPath,
        color: Colors.white,
      ),
      minLeadingWidth: 24,
      horizontalTitleGap: 12.0,
    );
  }
}
