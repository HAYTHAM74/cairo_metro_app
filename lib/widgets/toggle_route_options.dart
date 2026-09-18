import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleRouteOptions extends StatelessWidget {
  const ToggleRouteOptions({super.key, required this.routeController});
  final RouteController routeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final options = routeController.tripOptions;
      
      if (!options.containsKey('shortest') || !options.containsKey('leastTransfers')) {
        return const SizedBox.shrink();
      }
      
      final isShortest = routeController.isShortestRouteSelected.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              routeController.isShortestRouteSelected.value = true;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isShortest ? const Color(0xFF1565C0) : const Color(0xFFFFFFFF),
            ),
            child: Text(
              "Shortest route",
              style: TextStyle(
                color: isShortest ? const Color(0xFFFFFFFF) : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              routeController.isShortestRouteSelected.value = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !isShortest ? const Color(0xFF1565C0) : const Color(0xFFFFFFFF),
            ),
            child: Text(
              "Least transitions route",
              style: TextStyle(
                color: !isShortest ? const Color(0xFFFFFFFF) : Colors.black,
              ),
            ),
          ),
        ],
      );
    });
  }
}