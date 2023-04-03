import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(image: AssetImage("images/applogo.jpeg")),
      title: const Text(
        "ToDayDo",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      showLoader: false,
      loadingText: const Text("welcom..."),
      navigator: const HomePage(),
      durationInSeconds: 1,
    );
  }
}
