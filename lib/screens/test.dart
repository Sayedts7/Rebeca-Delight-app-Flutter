// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:rebeca_delight/constants/reusable.dart';
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   var code;
//   TextEditingController phonenumbercontroler = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             IntlPhoneField(
//               controller: phonenumbercontroler,
//               decoration: const InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(),
//                 ),
//               ),
//               initialCountryCode: 'IN',
//               onChanged: (phone) {
//                 print(phonenumbercontroler.text);
//                 print(phone.countryCode);
//                 code = phone.countryCode;
//               },
//             ),
//             ButtonRound(text: 'Click', ontap: (){
//               // print(phonenumbercontroler.text.toString());
//               print(code+phonenumbercontroler.text);
//               setState(() {
//
//               });
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
