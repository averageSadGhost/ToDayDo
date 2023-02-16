import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import 'services/theme_services.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeServices().getTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
