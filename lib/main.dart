import 'package:cairo_metro_app/services/coordinate_service.dart';
import 'package:cairo_metro_app/widgets/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  // Injects the dictionary into memory globally
  Get.put(CoordinateService());
  runApp(MaterialApp(home: TestWidget(),));
}

/*String _timeCalc(int numOfStations) {
    int totalMinutes = (numOfStations - 1) * 3;

    if (totalMinutes >= 60) {
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      String formattedMinutes = minutes.toString().padLeft(2, '0');
      return "$hours:$formattedMinutes hours";
    } else {
      return "$totalMinutes minutes";
    }
  }*/