import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import 'services/theme_services.dart';
import 'package:todo/db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeServices().getTheme,
      title: 'ToDayDo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
