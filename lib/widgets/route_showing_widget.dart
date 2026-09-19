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

            // 1. Calculate the line used to reach this station
            int? incomingLine;
            if (index > 0) {
              final previousStation = targetRoute[index - 1];
              final sharedPrev = station.lines.toSet().intersection(
                previousStation.lines.toSet(),
              );
              if (sharedPrev.isNotEmpty) incomingLine = sharedPrev.first;
            }

            // 2. Calculate the line used to leave this station
            int? outgoingLine;
            if (index < targetRoute.length - 1) {
              final nextStation = targetRoute[index + 1];
              final sharedNext = station.lines.toSet().intersection(
                nextStation.lines.toSet(),
              );
              if (sharedNext.isNotEmpty) outgoingLine = sharedNext.first;
            }

            // 3. A transfer ONLY occurs if both exist and they are different
            bool isActualTransfer =
                (incomingLine != null &&
                outgoingLine != null &&
                incomingLine != outgoingLine);

            // Display the outgoing line color (or incoming if it's the final destination)
            int activeLine = outgoingLine ?? incomingLine ?? 1;

            return RouteTile(
              station: station,
              currentLine: activeLine,
              // Pass the transfer target only if a physical line change happens
              transferTo: isActualTransfer ? 'Line $outgoingLine' : null,
            );
          },
        ),
      );
    });
  }
}
