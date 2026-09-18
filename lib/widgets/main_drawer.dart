import 'package:cairo_metro_app/controllers/route_controller.dart';
import 'package:cairo_metro_app/controllers/user_data_controller.dart';
import 'package:cairo_metro_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});
  final userController = Get.find<UserDataController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Obx(
            () => UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1565C0)),
              accountName: Text(
                userController.username.value,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('data'),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.confirmation_number_outlined,
              color: Color(0xFF1565C0),
            ),
            title: const Text('Tickets & Prices'),
            onTap: () {
              Get.back();
              Get.dialog(
                Dialog(
                  // 1. Reduce the default massive margins on the left and right
                  insetPadding: const EdgeInsets.symmetric(horizontal: 12),
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 4.0, // 2. Allow the user to zoom in up to 4x
                    child: SizedBox(
                      width: Get
                          .width, // 3. Force the container to take the full screen width
                      child: Image.asset(
                        'assets/images/cairo_metro_prices.jpg', // Replace with your actual asset path
                        fit: BoxFit
                            .fitWidth, // 4. Stretch the image to fill that full width
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              GetStorage().remove('currentUserProfile');
              if (Get.isRegistered<RouteController>()) {
                final routeCtrl = Get.find<RouteController>();
                routeCtrl.originStation.value = null;
                routeCtrl.destinationStation.value = null;
                routeCtrl.tripOptions.clear();
                routeCtrl.isShortestRouteSelected.value = true;
              }
              Get.offAll(() => LoginPage());
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
