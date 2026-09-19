import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cairo_metro_app/controllers/route_controller.dart';

class PriceTimeWidget extends GetView<RouteController> {
  const PriceTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.tripOptions.isEmpty) {
        return const SizedBox.shrink();
      }

      final isShortest = controller.isShortestRouteSelected.value;

      final normalFare = isShortest
          ? controller.normalFareShortest.value
          : controller.normalFareLeastTransfer.value;

      final discountedFare = isShortest
          ? controller.discountedFareShortest.value
          : controller.discountedFareLeastTransfer.value;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1)},
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Standard Ticket',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$normalFare EGP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: discountedFare > 0
                          ? TextDecoration.lineThrough
                          : null,
                      color: discountedFare > 0 ? Colors.grey : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            if (discountedFare > 0)
              TableRow(
                decoration: BoxDecoration(color: Colors.blue.shade50),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your Fare (Discounted)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$discountedFare EGP',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
