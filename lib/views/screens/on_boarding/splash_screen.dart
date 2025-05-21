import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CupertinoActivityIndicator()));
  }
}
