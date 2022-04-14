import 'package:flutter/material.dart';
import 'package:get/get.dart';
/// Controllers
import 'package:task_app/main_controller.dart';
/// Screens
import 'home_module/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Task Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, widget) {
        // init Controller to get device size screen
        Get.put(MainController());
        return widget!;
      },
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
