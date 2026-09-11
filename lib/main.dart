import 'package:cairo_metro_app/widgets/test_widget.dart';
import 'package:flutter/material.dart';

void main()
{
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