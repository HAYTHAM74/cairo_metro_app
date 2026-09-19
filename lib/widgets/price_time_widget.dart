import 'package:cairo_metro_app/constants/app_constants.dart';
import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceTimeWidget extends GetView<RouteController> {
  const PriceTimeWidget({super.key});

  Future<void> _openTicketGuide() async {
    final Uri uri = Uri.parse(AppConstants.metroTicketGuideVideoUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar(
          'Notice',
          'Could not open YouTube video guide.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Notice',
        'Could not open video guide.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF1565C0), size: 22),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildYouTubeButton() {
    return Tooltip(
      message: 'Watch how to purchase a Cairo Metro ticket',
      child: InkWell(
        onTap: _openTicketGuide,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFF0000),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.tripOptions.isEmpty || controller.currentRoute.isEmpty) {
        return const SizedBox.shrink();
      }

      final isShortest = controller.isShortestRouteSelected.value;

      final normalFare = isShortest
          ? controller.normalFareShortest.value
          : controller.normalFareLeastTransfer.value;

      final discountedFare = isShortest
          ? controller.discountedFareShortest.value
          : controller.discountedFareLeastTransfer.value;

      final stationCount = controller.stationCount;
      final tripTimeMinutes = controller.estimatedTripTimeMinutes;
      final transferCount = controller.transferCount;

      return Card(
        elevation: 1.5,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Trip Summary Metrics Row
              Row(
                children: [
                  _buildMetricItem(
                    icon: Icons.directions_subway,
                    label: 'Stations',
                    value: '$stationCount',
                  ),
                  _buildDivider(),
                  _buildMetricItem(
                    icon: Icons.access_time_filled,
                    label: 'Est. Time',
                    value: '$tripTimeMinutes min',
                  ),
                  _buildDivider(),
                  _buildMetricItem(
                    icon: Icons.swap_horiz_rounded,
                    label: 'Transfers',
                    value: '$transferCount',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Ticket Fare Table with YouTube Ticket Guide
              Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 6.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$normalFare EGP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: discountedFare > 0
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: discountedFare > 0
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 6),
                            _buildYouTubeButton(),
                          ],
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
            ],
          ),
        ),
      );
    });
  }
}
