import 'dart:async';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: 1000), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorResource.color0C3062,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text('DELEARS PRO',
    style: TextStyle(
    fontSize: 33,
      color: Colors.white,
    ),
    ),
        ),
      )
    );
  }
}
