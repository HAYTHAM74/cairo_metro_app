import 'package:cairo_metro_app/controllers/user_data_controller.dart';
import 'package:cairo_metro_app/data/metro_network.dart';
import 'package:cairo_metro_app/models/station.dart';
import 'package:cairo_metro_app/services/fare_calc_service.dart';
import 'package:cairo_metro_app/services/routing_service.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  late final MetroNetwork network;
  late final RoutingService routingService;

  final Rx<Station?> originStation = Rx<Station?>(null);
  final Rx<Station?> destinationStation = Rx<Station?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isShortestRouteSelected = true.obs;
  final normalFareShortest = 0.obs;
  final normalFareLeastTransfer = 0.obs;
  final discountedFareShortest = 0.obs;
  final discountedFareLeastTransfer = 0.obs;
  final RxMap<String, List<Station>> tripOptions =
      <String, List<Station>>{}.obs;
  UserDataController get userController => Get.find<UserDataController>();

  @override
  void onInit() {
    super.onInit();
    network = MetroNetwork();
    network.buildNetwork();
    routingService = RoutingService(network);
  }

  (int, int) updateFaresForRoute(String activeKey) {
    final fareCalc = FareCalcService();
    bool isSenior = userController.ageCategory.value == '60+';
    print(isSenior);
    print(userController.ageCategory.value);
    bool isSpecialNeeds = userController.isSpecialNeeds.value;
    return fareCalc.ticketCalc(
      tripOptions[activeKey]!.length,
      isSenior,
      isSpecialNeeds,
    );
  }

  void calculateRoutes() {
    if (originStation.value == null || destinationStation.value == null) {
      print('Start or destination station is not selected');
      return;
    }
    if (originStation.value!.id == destinationStation.value!.id) {
      print("Start and destination can't be the same");
      return;
    }

    isLoading.value = true;

    final routes = routingService.generateTripOptions(
      start: originStation.value!,
      destination: destinationStation.value!,
    );

    tripOptions.assignAll(routes);

    if (tripOptions.containsKey('primary')) {
      final (normal, discounted) = updateFaresForRoute('primary');
      normalFareShortest.value = normal;
      discountedFareShortest.value = discounted;
    } else {
      if (tripOptions.containsKey('shortest')) {
        final (normal, discounted) = updateFaresForRoute('shortest');
        normalFareShortest.value = normal;
        discountedFareShortest.value = discounted;
      }

      if (tripOptions.containsKey('leastTransfers')) {
        final (normal, discounted) = updateFaresForRoute('leastTransfers');
        normalFareLeastTransfer.value = normal;
        discountedFareLeastTransfer.value = discounted;
      }
    }

    isLoading.value = false;
    isShortestRouteSelected.value = true;
    
  }
}
