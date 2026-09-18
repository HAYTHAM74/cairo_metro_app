import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cairo_metro_app/services/coordinate_service.dart';

class LocationController extends GetxController {
  final coordinates = CoordinateService();

  Future<String?> getCurrentNearestStationId() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      return null;
    }

    final position = await Geolocator.getCurrentPosition();
    return nearestStation(position.latitude, position.longitude);
  }

  Future<String?> getDestinationNearestStationId(String place) async {
    place = place.trim();
    if (place.isEmpty) return null;

    place = place.replaceAll(RegExp(r'\s+'), ' ');
    if (!place.toLowerCase().contains('cairo')) place += ', Cairo';
    if (!place.toLowerCase().contains('egypt')) place += ', Egypt';

    try {
      final geocoding = Geocoding();
      final placeLoc = await geocoding.locationFromAddress(place);
      if (placeLoc.isEmpty) return null;
      return nearestStation(placeLoc.first.latitude, placeLoc.first.longitude);
    } catch (e) {
      Get.snackbar('Error', 'Could not find this location.');
      return null;
    }
  }

  String nearestStation(double lat, double long) {
    var minDistance = double.infinity;
    late String nearest;

    for (final location in coordinates.stationsCoordinates.entries) {
      final distance = Geolocator.distanceBetween(
        lat,
        long,
        location.value.lat,
        location.value.lng,
      );

      if (distance <= minDistance) {
        minDistance = distance;
        nearest = location.key;
      }
    }
    return nearest;
  }
}