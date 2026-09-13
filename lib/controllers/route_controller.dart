import 'package:cairo_metro_app/data/metro_network.dart';
import 'package:cairo_metro_app/models/station.dart';
import 'package:cairo_metro_app/services/routing_service.dart';
import 'package:get/get.dart';

class RouteController extends GetxController
{
  late final MetroNetwork network;
  late final RoutingService routingService;

  final Rx<Station?> originStation = Rx<Station?>(null);
  final Rx<Station?> destinationStation = Rx<Station?>(null);
  final RxBool isLoading = false.obs;
  final RxMap<String, List<Station>> tripOptions = <String, List<Station>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    network = MetroNetwork();
    network.buildNetwork();
    routingService = RoutingService(network);
  }

  void calculateRoutes()
  {
    if(originStation.value == null || destinationStation.value == null)
    {
      print('Start or destination station is not selected');
      return;
    }
    if(originStation.value!.id == destinationStation.value!.id)
    {
      print("Start and destination can't be the same");
      return;
    }
    isLoading.value = true;
    final routes = routingService.generateTripOptions(start: originStation.value!, destination: destinationStation.value!);
    tripOptions.assignAll(routes);
    isLoading.value = false;
  }
}