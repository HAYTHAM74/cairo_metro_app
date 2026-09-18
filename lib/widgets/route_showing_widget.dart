import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:cairo_metro_app/models/station.dart';
import 'package:cairo_metro_app/widgets/route_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteShowingWidget extends StatelessWidget {
  const RouteShowingWidget({super.key, required this.routeController});
  final RouteController routeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final options = routeController.tripOptions;
      if (routeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (options.isEmpty) {
        return const Center(
          child: Text("Select stations to generate a route."),
        );
      }
      List<Station> targetRoute = [];
      if (options.containsKey("primary")) {
        targetRoute = options['primary']!.toList();
      } else {
        final isShortest = routeController.isShortestRouteSelected.value;
        targetRoute = isShortest
            ? options['shortest'] ?? []
            : options['leastTransfers'] ?? [];
      }
      return SizedBox(
        height: double.infinity,
        child: ListView.builder(
          itemCount: targetRoute.length,
          itemBuilder: (context, index) {
            final station = targetRoute[index];
            int activeLine = 1;
            if (index < targetRoute.length - 1) {
              final nextStation = targetRoute[index + 1];
              final sharedLines = station.lines.toSet().intersection(
                nextStation.lines.toSet(),
              );
              if (sharedLines.isNotEmpty) {
                activeLine = sharedLines.first;
              }
            } else if (index > 0) {
              final previousStation = targetRoute[index - 1];
              final sharedLines = station.lines.toSet().intersection(
                previousStation.lines.toSet(),
              );
              if (sharedLines.isNotEmpty) {
                activeLine = sharedLines.first;
              }
            }
            return station.isTransfer
                ? RouteTile(
                    station: station,
                    currentLine: activeLine,
                    transferTo: (index + 1 == targetRoute.length || index == 0) ? "" : targetRoute[index + 1].name,
                  )
                : RouteTile(station: station, currentLine: activeLine);
          },
        ),
      );
    });
  }
}
