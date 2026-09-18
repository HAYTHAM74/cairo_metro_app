import 'package:cairo_metro_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final nameController = TextEditingController();

  final atext = false.obs;
  final addm = false.obs;
  final isSpecialNeeds = false.obs;

  //List tripType = <String>['Less switching of stations', 'The shortest way'];

  final tripTypeController = TextEditingController();

  final List age = <String>['1-25', '26-59', '60+'];

  final ticketCatagoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 18,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/cairo_metro_logo.png',
                //height: MediaQuery.sizeOf(context).height * 0.5,
              ),

              // Username
              TextField(
                controller: nameController,

                onChanged: (s) {
                  atext.value = s.isNotEmpty;
                },

                decoration: InputDecoration(
                  labelText: 'Username',

                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF1565C0),
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF1565C0),
                      width: 2,
                    ),
                  ),
                ),
              ),

              // Age + Special Needs
              Row(
                children: [
                  Expanded(
                    child: DropdownMenu(
                      onSelected: (s) {
                        if (s != null) {
                          addm.value = true;
                        }
                      },

                      controller: ticketCatagoryController,

                      width: double.infinity,

                      enableFilter: true,
                      enableSearch: true,

                      label: const Text('Enter Your Age'),

                      leadingIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF1565C0),
                      ),

                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1565C0),
                            width: 2,
                          ),
                        ),
                      ),

                      dropdownMenuEntries: [
                        for (var ticket in age)
                          DropdownMenuEntry(value: ticket, label: ticket),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Checkbox(
                            activeColor: const Color(0xFF1565C0),

                            value: isSpecialNeeds.value,

                            onChanged: (value) {
                              isSpecialNeeds.value = value ?? false;
                            },
                          ),

                          const Flexible(
                            child: Text(
                              "Special needs",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Enter Button
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.45,

                child: Obx(() {
                  return ElevatedButton.icon(
                    onPressed: (atext.value && addm.value)
                        ? () {
                            final box = GetStorage();

                            box.write('currentUserProfile', {
                              'username': nameController.text,
                              'ageCategory': ticketCatagoryController.text,
                              'isSpecialNeeds': isSpecialNeeds.value,
                            });
                            Get.to(
                              () => HomeScreen(),
                              arguments: nameController.text,
                              transition: Transition.leftToRight,
                            );
                          }
                        : null,

                    label: const Text(
                      'Enter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    icon: const Icon(Icons.east),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),

                      foregroundColor: Colors.white,

                      disabledBackgroundColor: Colors.grey.shade300,

                      disabledForegroundColor: Colors.grey.shade500,

                      elevation: 3,

                      padding: const EdgeInsets.symmetric(vertical: 15),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
