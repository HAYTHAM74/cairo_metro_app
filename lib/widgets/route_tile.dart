import 'package:cairo_metro_app/models/station.dart';
import 'package:flutter/material.dart';

class RouteTile extends StatelessWidget {
  const RouteTile({
    super.key,
    required this.station,
    required this.currentLine,
    this.transferTo
  });

  final Station station;
  final int currentLine;
  final String? transferTo;

  static const Map<int, Color> linesToColor = {
    1: Colors.blue,
    2: Colors.red,
    3: Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final Color lineColor =  linesToColor[currentLine] ?? Colors.grey;

    return ListTile(
      leading: Container(
        color: lineColor,
        height: double
            .infinity, 
        width: 5,
      ),
      title: Text(
        station.isTransfer ? (transferTo == "" ? station.name : '${station.name}, Transfer here to $transferTo') : station.name,
        style: TextStyle(
          fontWeight: station.isTransfer ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
