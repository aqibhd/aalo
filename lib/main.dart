import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
