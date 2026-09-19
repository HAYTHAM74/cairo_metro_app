import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:cairo_metro_app/controllers/user_data_controller.dart';
import 'package:cairo_metro_app/screens/home_screen.dart';
import 'package:cairo_metro_app/screens/login_screen.dart';
import 'package:cairo_metro_app/services/coordinate_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main()
async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CoordinateService());
  Get.put(RouteController());
  Get.put(UserDataController());
  runApp(const CairoMetroApp());
}

class CairoMetroApp extends StatelessWidget {
  const CairoMetroApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userData = box.read('currentUserProfile');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cairo Metro',
      home: userData != null ? HomeScreen() : LoginPage(),
    );
  }
}