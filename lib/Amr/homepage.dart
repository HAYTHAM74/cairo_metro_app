import 'package:cairo_metro_app/Amr/sataion.dart' show Station;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

class home_page extends StatelessWidget {
  home_page({super.key});

  final List<Station> stations = [

    // =========================
    // Line 1
    // =========================

    Station("Helwan", 29.8489, 31.3342),
    Station("Ain Helwan", 29.8628, 31.3250),
    Station("Helwan University", 29.8689, 31.3203),
    Station("Wadi Hof", 29.8794, 31.3133),
    Station("Hadayek Helwan", 29.8972, 31.3042),
    Station("El-Maasara", 29.9061, 31.2997),
    Station("Tora El-Asmant", 29.9258, 31.2878),
    Station("Kozzika", 29.9361, 31.2817),
    Station("Tora El-Balad", 29.9464, 31.2736),
    Station("Sakanat El-Maadi", 29.9528, 31.2633),
    Station("Maadi", 29.9597, 31.2581),
    Station("Hadayek El-Maadi", 29.9700, 31.2506),
    Station("Dar El-Salam", 29.9819, 31.2422),
    Station("El-Zahraa", 29.9953, 31.2317),
    Station("Mar Girgis", 30.0058, 31.2294),
    Station("El-Malek El-Saleh", 30.0169, 31.2308),
    Station("Al-Sayeda Zeinab", 30.0292, 31.2353),
    Station("Saad Zaghloul", 30.0367, 31.2381),

    Station("Sadat", 30.0444, 31.2356),

    Station("Nasser", 30.0536, 31.2389),
    Station("Orabi", 30.0575, 31.2425),

    Station("Al-Shohadaa", 30.0619, 31.2461),

    Station("Ghamra", 30.0689, 31.2647),
    Station("El-Demerdash", 30.0772, 31.2778),
    Station("Manshiet El-Sadr", 30.0822, 31.2878),
    Station("Kobri El-Qobba", 30.0869, 31.2939),
    Station("Hammamat El-Qobba", 30.0903, 31.2981),
    Station("Saray El-Qobba", 30.0981, 31.3047),
    Station("Hadayeq El-Zaitoun", 30.1053, 31.3100),
    Station("Helmeyet El-Zaitoun", 30.1144, 31.3139),
    Station("El-Matareyya", 30.1214, 31.3139),
    Station("Ain Shams", 30.1311, 31.3192),
    Station("Ezbet El-Nakhl", 30.1392, 31.3244),
    Station("El-Marg", 30.1522, 31.3356),
    Station("New El-Marg", 30.1633, 31.3383),


    // =========================
    // Line 2
    // =========================

    Station("El-Mounib", 29.9814, 31.2119),
    Station("Sakiat Mekky", 29.9956, 31.2086),
    Station("Omm El-Masryeen", 30.0053, 31.2081),
    Station("El Giza", 30.0106, 31.2069),
    Station("Faisal", 30.0172, 31.2039),

    Station("Cairo University", 30.0261, 31.2011),

    Station("El Bohoth", 30.0358, 31.2003),
    Station("Dokki", 30.0383, 31.2120),
    Station("Opera", 30.0419, 31.2253),

    // Sadat already exists

    Station("Mohamed Naguib", 30.0453, 31.2431),

    // Attaba is also Line 3
    Station("Attaba", 30.0525, 31.2469),

    // Al-Shohadaa already exists

    Station("Masarra", 30.0711, 31.2450),
    Station("Rod El-Farag", 30.0806, 31.2456),
    Station("St. Teresa", 30.0883, 31.2456),
    Station("Khalafawy", 30.0981, 31.2453),
    Station("Mezallat", 30.1050, 31.2467),
    Station("Kolleyyet El-Zeraa", 30.1139, 31.2486),
    Station("Shubra El-Kheima", 30.1225, 31.2447),


    // =========================
    // Line 3
    // =========================

    Station("Adly Mansour", 30.1469, 31.4214),
    Station("El Haykestep", 30.1439, 31.4047),
    Station("Omar Ibn El-Khattab", 30.1406, 31.3942),
    Station("Qobaa", 30.1347, 31.3839),
    Station("Hesham Barakat", 30.1311, 31.3728),
    Station("El-Nozha", 30.1283, 31.3600),
    Station("Nadi El-Shams", 30.1222, 31.3439),
    Station("Alf Maskan", 30.1181, 31.3397),
    Station("Heliopolis Square", 30.1081, 31.3381),
    Station("Haroun", 30.1011, 31.3328),
    Station("Al-Ahram", 30.0914, 31.3264),
    Station("Koleyet El-Banat", 30.0836, 31.3289),
    Station("Stadium", 30.0731, 31.3175),
    Station("Fair Zone", 30.0733, 31.3011),
    Station("Abbassia", 30.0697, 31.2808),
    Station("Abdou Pasha", 30.0647, 31.2747),
    Station("El Geish", 30.0619, 31.2669),
    Station("Bab El Shaaria", 30.0539, 31.2561),

    // Attaba already exists
    // Nasser already exists

    Station("Maspero", 30.0556, 31.2322),
    Station("Safaa Hegazy", 30.0625, 31.2225),
    Station("Kit Kat", 30.0667, 31.2131),

    // =========================
    // Line 3 - Rod El-Farag branch
    // =========================

    Station("Sudan", 30.0697, 31.2053),
    Station("Imbaba", 30.0758, 31.2075),
    Station("El-Bohy", 30.0822, 31.2106),
    Station("El-Qawmia", 30.0933, 31.2089),
    Station("Ring Road", 30.0964, 31.1997),
    Station("Rod El-Farag Corridor", 30.1019, 31.1842),


    // =========================
    // Line 3 - Cairo University branch
    // =========================

    Station("Tawfikia", 30.0653, 31.2025),
    Station("Wadi El Nile", 30.0583, 31.2011),
    Station("Gamat El Dowal", 30.0508, 31.1997),
    Station("Boulak El Dakrour", 30.0361, 31.1964),

    // Cairo University already exists
  ];

  final name = Get.arguments;
  final sourceStationController = TextEditingController();
  final destenationStationController = TextEditingController();
  final destenationPlaceController = TextEditingController();
  var selectedDestStation = Rxn<Station>();
  var selectedSourceStation = Rxn<Station>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello $name !'),
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Color(0xFFFFFFFF),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(spacing: 16,
            children: [
              Row(
                children: [
                  Obx(() {
                  return DropdownMenu<Station>(
                    initialSelection: selectedSourceStation.value,

                    dropdownMenuEntries: stations.where(
                          (station) =>
                      station != selectedDestStation.value,
                    ).map((station) {
                      return DropdownMenuEntry<Station>(
                        value: station,
                        label: station.name,
                      );
                    }).toList(),

                    onSelected: (value) {
                      selectedSourceStation.value = value!;
                    },
                  );
                }),
                  Spacer(),
                  IconButton(onPressed: () {
                    GetCurrNearstLocation();
                  }, icon: Icon(Icons.my_location))
                ],
              ),
              Row(
                children: [
                  Obx(() {
                    return DropdownMenu<Station>(
                      initialSelection: selectedDestStation.value,

                      dropdownMenuEntries: stations.where(
                            (station) =>
                        station != selectedSourceStation.value,
                      ).map((station) {
                        return DropdownMenuEntry<Station>(
                          value: station,
                          label: station.name,
                        );
                      }).toList(),

                      onSelected: (value) {
                        selectedDestStation.value = value!;
                      },
                    );
                  }),
                  Spacer(),
                  IconButton(onPressed: () {
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
                      onConfirm: () {
                        GetDestNerstLoc(destenationPlaceController.text);
                        Get.back();
                      },
                    );
                  }, icon: Icon(Icons.search))
                ],
              ),
              ElevatedButton.icon(onPressed: () {},
                  label: const Text('Nearest Station '),
                  icon: const Icon(Icons.location_on),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: const Color(0xFFFFFFFF),
                  ))

            ]),
      ),
    );
  }

  Future<void> GetCurrNearstLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.snackbar('Error',
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }


    final position = await Geolocator.getCurrentPosition();
    print('lat : ${position.latitude}, long: ${position.longitude}');
    final nearest = nearestStation(position.latitude, position.longitude);
    selectedSourceStation.value=nearest;
    print("Nearest station: ${nearest.name}");
    print("Lat: ${nearest.lat}");
    print("Long: ${nearest.long}");
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${nearest.lat},${nearest
          .long}',
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }



  Future<void> GetDestNerstLoc( String place) async {
    place = place.trim();
    if (place.isEmpty) {
      return ;
    }

    place = place.replaceAll(RegExp(r'\s+'), ' ');

    if (!place.toLowerCase().contains('cairo')) {
      place += ', Cairo';
    }

    if (!place.toLowerCase().contains('egypt')) {
      place += ', Egypt';
    }
    final geocoding = Geocoding();
    final placeLoc = await geocoding.locationFromAddress(place);
    print('${placeLoc.first.latitude},${placeLoc.first.longitude}');
    final nearest = nearestStation(placeLoc.first.latitude, placeLoc.first.longitude);
    print(
        nearest.name +
            ' Station '
    );
    selectedDestStation.value=nearest;
  }

  Station nearestStation(double lat, double long) {
    var minDistance = double.infinity;
    late Station nearest;

    for (final station in stations) {
      final distance = Geolocator.distanceBetween(
        lat,
        long,
        station.lat,
        station.long,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = station;
      }
    }

    return nearest;
  }

}
