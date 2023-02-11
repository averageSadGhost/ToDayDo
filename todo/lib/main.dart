import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.teal,
          // ignore: deprecated_member_use
          backgroundColor: Colors.black),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const NotificationScreen(payload: "Title | Description | 10:20"),
    );
  }
}
