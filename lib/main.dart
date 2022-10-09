import 'dart:async';

import 'package:aalo/widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Aalo());
}

class Aalo extends StatelessWidget {
  const Aalo({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aalo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => FlutterNativeSplash.remove());
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("aalo"),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black.withOpacity(0.05)),
      ),
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomActionBar(
            onTap: (value) => setState(() {
              currentPage = value;
            }),
            bottomActionBarItems: [
              bottomActionBarItem(
                  'assets/svg/home.svg',
                  currentPage == 0
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xff333333)),
              bottomActionBarItem(
                  'assets/svg/search.svg',
                  currentPage == 1
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xff333333)),
              bottomActionBarItem(
                  'assets/svg/heart.svg',
                  currentPage == 2
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xff333333)),
              bottomActionBarItem(
                  'assets/svg/list.svg',
                  currentPage == 3
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xff333333)),
            ],
          ),
        )
      ]),
    );
  }
}
