// import 'package:flutter/material.dart';
//
// class Cart extends StatefulWidget {
//   final String item, image, price;
//   const Cart({Key? key, required this.item, required this.image, required this.price}) : super(key: key);
//
//   @override
//   State<Cart> createState() => _CartState();
// }
//
// class _CartState extends State<Cart> {
//
//   List<String> cart = [];
//
//
//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     cart.add(widget.item);
//     setState(() {
//
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cart.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: ListTile(
//                     title: Text(cart[index]),
//                     leading: Image(
//                       height: 100,
//                       width: 100,
//                       image: AssetImage(widget.image),),
//
//                     trailing: Text('Price ' +widget.price+ ' Rs'),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
