import 'package:cairo_metro_app/controllers/location_controller.dart';
import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:cairo_metro_app/services/coordinate_service.dart';
import 'package:cairo_metro_app/widgets/main_drawer.dart';
import 'package:cairo_metro_app/widgets/price_time_widget.dart';
import 'package:cairo_metro_app/widgets/route_showing_widget.dart';
import 'package:cairo_metro_app/widgets/toggle_route_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cairo_metro_app/models/station.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RouteController controller = Get.find<RouteController>();
  final LocationController locationController = Get.put(LocationController());
  final coordinates = CoordinateService();
  late final stations = {
    ...controller.network.line1Names,
    ...controller.network.line2Names,
    ...controller.network.line3Trunk,
    ...controller.network.line3North,
    ...controller.network.line3South,
  }.toList()..sort();

  final startStation = RxnString();
  final destinationStation = RxnString();
  final name = Get.arguments;
  final sourceStationController = TextEditingController();
  final destenationStationController = TextEditingController();
  final destenationPlaceController = TextEditingController();
  final destinationMenuController = TextEditingController();
  final startMenuController = TextEditingController();
  final selectedDestStation = Rxn<Station>();
  final selectedSourceStation = Rxn<Station>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final Map<String, dynamic> userData = box.read('currentUserProfile') ?? {};
    final String username = userData['username'] ?? 'Traveler';
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Hello $username !'),
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownMenu<String>(
                    requestFocusOnTap: true,
                    enableSearch: true,
                    enableFilter: true,
                    menuHeight: 500,
                    controller: startMenuController,
                    width: double.infinity,
                    hintText: "Choose start station",

                    dropdownMenuEntries: stations.map((stationId) {
                      final String stationName =
                          controller.network
                              .findStationByName(stationId)
                              ?.name ??
                          stationId;

                      return DropdownMenuEntry<String>(
                        value: stationId,
                        label: stationName,
                      );
                    }).toList(),

                    onSelected: (value) {
                      startStation.value = value;
                      //selectedSourceStation.value = value!;
                    },
                  ),
                ),
                //Spacer(),
                IconButton(
                  onPressed: () async {
                    final nearestId = await locationController
                        .getCurrentNearestStationId();
                    if (nearestId != null) {
                      final nearestName =
                          controller.network
                              .findStationByName(nearestId)
                              ?.name ??
                          nearestId;
                      startStation.value = nearestId;
                      startMenuController.text = nearestName;
                      final uri = Uri.parse(
                        'https://www.google.com/maps/dir/?api=1&destination=${coordinates.stationsCoordinates[nearestId]!.lat},${coordinates.stationsCoordinates[nearestId]!.lng}',
                      );
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  icon: Icon(Icons.my_location),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return DropdownMenu<String>(
                      
                      requestFocusOnTap: true,
                      enableSearch: true,
                      enableFilter: true,
                      menuHeight: 500,
                      controller: destinationMenuController,
                      width: double.infinity,
                      hintText: "Select Destination Station",

                      dropdownMenuEntries: stations
                          .where((stationId) => stationId != startStation.value)
                          .map((stationId) {
                            final String stationName =
                                controller.network
                                    .findStationByName(stationId)
                                    ?.name ??
                                stationId;

                            return DropdownMenuEntry<String>(
                              value: stationId,
                              label: stationName,
                            );
                          })
                          .toList(),

                      onSelected: (value) {
                        destinationStation.value = value!;
                      },
                    );
                  }),
                ),
                //Spacer(),
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Enter Station",
                      content: TextField(
                        controller: destenationPlaceController,
                        decoration: const InputDecoration(
                          hintText: "Place name",
                        ),
                      ),
                      textConfirm: "OK",
                      textCancel: "Cancel",
                      onConfirm: () async {
                        Get.back();

                        final nearestId = await locationController
                            .getDestinationNearestStationId(
                              destenationPlaceController.text,
                            );

                        if (nearestId != null) {
                          final nearestName =
                              controller.network
                                  .findStationByName(nearestId)
                                  ?.name ??
                              nearestId;
                          destinationStation.value = nearestId;
                          destinationMenuController.text = nearestName;
                          destenationPlaceController.clear();
                        }
                      },
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (startStation.value == null ||
                    destinationStation.value == null) {
                  Get.snackbar(
                    "Error",
                    "Please, choose your start and destination",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
                Station? confirmedStartStation = controller.network
                    .findStationByName(startStation.value!);
                Station? confirmedDestinationStation = controller.network
                    .findStationByName(destinationStation.value!);

                if (confirmedStartStation == null ||
                    confirmedDestinationStation == null) {
                  Get.snackbar(
                    "Error",
                    "Could not locate stations in the network",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                controller.originStation.value = confirmedStartStation;
                controller.destinationStation.value =
                    confirmedDestinationStation;
                controller.calculateRoutes();
                destenationPlaceController
                    .clear(); //**************************************************
              },
              label: const Text('Show route'),
              icon: const Icon(Icons.location_on),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            ToggleRouteOptions(routeController: controller),
            PriceTimeWidget(),
            Expanded(child: RouteShowingWidget(routeController: controller)),
          ],
        ),
      ),
    );
  }
}
