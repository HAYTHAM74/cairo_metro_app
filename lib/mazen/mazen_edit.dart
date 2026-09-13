import 'package:flutter/material.dart';

import 'package:get/get.dart';


class home_page extends StatelessWidget {
  home_page({super.key});

  final start_input = TextEditingController();
  final destination_input = TextEditingController();
  final started = false.obs;
  final Ended = false.obs;
  final finaly = false.obs;
  final b = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "u",
    "i",
    "u",
    "p",
    "m",
    "n",
    "k",
    "o"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          spacing: 20,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              spacing: 20,

              children: [


                DropdownMenu<String>(
                    controller: start_input,
                    hintText: "select the station",


                    menuHeight: 400,
                    width: 350,

                    enableSearch: true,
                    enableFilter: true,
                    onSelected: (value) {
                      started.value = true;
                    },
                    dropdownMenuEntries: [
                      for(String item in b)
                        DropdownMenuEntry(value: item, label: item)


                    ]

                ),


                Obx(() {
                  return ElevatedButton(
                    onPressed: started.value ? () {

                    } : null,
                    child: Icon(Icons.search),
                  );
                }),


              ],

            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [

                DropdownMenu<String>(
                    controller: destination_input,
                    hintText: "select the station",


                    menuHeight: 400,
                    width: 350,

                    enableSearch: true,
                    enableFilter: true,
                    onSelected: (value) {
                      Ended.value = true;
                      finaly.value = true;
                    },
                    dropdownMenuEntries: [
                      for(String item in b)
                        DropdownMenuEntry(value: item, label: item)


                    ]),

                Obx(() {
                  return ElevatedButton(
                      onPressed: Ended.value ? () {} : null,
                      child: Icon(Icons.map)
                  );
                }),
              ],

            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0,
                  top: 150.0,
                  right: 0.0,
                  bottom: 0.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 40,
                children: [
                  Obx(() {
                    return ElevatedButton(
                        onPressed: finaly.value? () {}:null, child: Text("Shortest path"));
                  }),
                  Obx(() {
                    return ElevatedButton(
                        onPressed:finaly.value? () {}:null, child: Text("Least transition"));
                  })
                ],
              ),
            )
          ],
        ),

      ),

    );
  }
}

