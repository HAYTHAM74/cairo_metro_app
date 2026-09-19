import 'package:cairo_metro_app/models/station.dart';
import 'package:flutter/material.dart';

class RouteTile extends StatelessWidget {
  const RouteTile({
    super.key,
    required this.station,
    required this.currentLine,
    this.transferTo,
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
    final Color lineColor = linesToColor[currentLine] ?? Colors.grey;

    // Evaluate if a transfer is ACTUALLY happening on this trip
    final bool isRealTransfer = transferTo != null && transferTo!.isNotEmpty;

    return ListTile(
      leading: Container(color: lineColor, height: double.infinity, width: 5),
      title: Text(
        isRealTransfer
            ? '${station.name}, Transfer here to $transferTo'
            : station.name,
        style: TextStyle(
          fontWeight: isRealTransfer ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
