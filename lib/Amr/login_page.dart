
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'homepage.dart';

class LoginPage extends StatelessWidget {
LoginPage({super.key});

final nameController = TextEditingController();

var atext = false.obs;
var addm = false.obs;
var isSpecialNeeds = false.obs;

List tripType = <String>[
'Less switching of stations',
'The shortest way'
];

final tripTypeController = TextEditingController();

List ticketCatagory = <String>[
'1-25',
'26-59',
'60 +'
];

final ticketCatagoryController = TextEditingController();

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF5F7FA),

body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(16),

child: ListView.builder(
itemCount: 1,

itemBuilder: (context, index) {
return Column(
spacing: 18,

children: [

// Logo
Image.asset(
'assets/images/logo.webp',
height:
MediaQuery.sizeOf(context).height * 0.5,
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
borderSide: BorderSide(
color: Colors.grey.shade300,
),
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

DropdownMenu(
onSelected: (s) {
if (s != null) {
addm.value = true;
}
},

controller: ticketCatagoryController,

width:
MediaQuery.sizeOf(context).width * 0.4,

enableFilter: true,
enableSearch: true,

label: const Text(
'Enter Your Age',
),

leadingIcon: const Icon(
Icons.person_outline,
color: Color(0xFF1565C0),
),

inputDecorationTheme:
InputDecorationTheme(
filled: true,
fillColor: Colors.white,

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(12),
),

enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(12),
borderSide: BorderSide(
color: Colors.grey.shade300,
),
),

focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(12),
borderSide: const BorderSide(
color: Color(0xFF1565C0),
width: 2,
),
),
),

dropdownMenuEntries: [
for (var ticket in ticketCatagory)
DropdownMenuEntry(
value: ticket,
label: ticket,
),
],
),

const SizedBox(width: 8),

Expanded(
child: Obx(
() => Row(
mainAxisSize: MainAxisSize.min,

children: [
Checkbox(
activeColor:
const Color(0xFF1565C0),

value: isSpecialNeeds.value,

onChanged: (value) {
isSpecialNeeds.value =
value ?? false;
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
width:
MediaQuery.sizeOf(context).width * 0.45,

child: Obx(
() {
return ElevatedButton.icon(
onPressed:
(atext.value && addm.value)
? () {
Get.to(
() => home_page(),

arguments:
nameController.text,

transition:
Transition.leftToRight,
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

icon: const Icon(
Icons.east,
),

style: ElevatedButton.styleFrom(
backgroundColor:
const Color(0xFF1565C0),

foregroundColor: Colors.white,

disabledBackgroundColor:
Colors.grey.shade300,

disabledForegroundColor:
Colors.grey.shade500,

elevation: 3,

padding:
const EdgeInsets.symmetric(
vertical: 15,
),

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(12),
),
),
);
},
),
),
],
);
},
),
),
),
);
}
}

