import 'dart:async';
import 'dart:ui';
import 'package:aalo/views/home.dart';
import 'package:aalo/views/liked.dart';
import 'package:aalo/views/more.dart';
import 'package:aalo/views/search.dart';
import 'package:aalo/widgets/bottom_action_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final int splashSecond = int.parse(FlutterConfig.get('SPLASH_SECOND'));
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: splashSecond), () => FlutterNativeSplash.remove());
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
      // appBar: AppBar(
      //   actions: currentPage == 0
      //       ? [
      //           const Padding(
      //             padding: EdgeInsets.all(8.0),
      //             child: AdditionalResourceButton(),
      //           )
      //         ]
      //       : null,
      //   elevation: 0,
      //   backgroundColor: Colors.black.withOpacity(0.1),
      //   title: currentPage != 1
      //       ? Text(pages[currentPage]['name'])
      //       : Container(
      //           height: 50,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.all(Radius.circular(50)),
      //               color: Colors.white),
      //         ),
      //   centerTitle: true,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.black.withOpacity(0.05)),
      // ),
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

class AdditionalResourceButton extends StatelessWidget {
  const AdditionalResourceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AdditionalResource())),
          child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
                  .withOpacity(0.5), //remove this when you add image.
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/svg/list.svg',
              width: 16,
              height: 16,
              color: Colors.white,
            )),
          ),
        ),
      ),
    );
  }
}
