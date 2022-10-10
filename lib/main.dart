import 'dart:async';

import 'package:aalo/views/home.dart';
import 'package:aalo/views/liked.dart';
import 'package:aalo/views/search.dart';
import 'package:aalo/widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
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
  final List<Map<String, dynamic>> pages = const [
    {'screen': Home(), 'name': "Home"},
    {'screen': Search(), 'name': "Search"},
    {'screen': Liked(), 'name': "Collection"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.1),
        title: currentPage != 1
            ? Text(pages[currentPage]['name'])
            : Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white),
              ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black.withOpacity(0.05)),
      ),
      body: Stack(children: [
        pages[currentPage]['screen'],
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
                      ? Colors.white.withOpacity(0.9)
                      : Color.fromARGB(255, 100, 100, 100).withOpacity(0.85)),
              bottomActionBarItem(
                  'assets/svg/search.svg',
                  currentPage == 1
                      ? Colors.white.withOpacity(0.9)
                      : Color.fromARGB(255, 100, 100, 100).withOpacity(0.85)),
              bottomActionBarItem(
                  'assets/svg/collection.svg',
                  currentPage == 2
                      ? Colors.white.withOpacity(0.9)
                      : Color.fromARGB(255, 100, 100, 100).withOpacity(0.85)),
            ],
          ),
        )
      ]),
    );
  }
}
