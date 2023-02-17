import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebeca_delight/cartModel/cart_model.dart';
import 'package:rebeca_delight/cartModel/db_helper.dart';
import 'package:rebeca_delight/constants/contstants.dart';
import 'package:rebeca_delight/constants/reusable.dart';
import 'package:rebeca_delight/screens/items_pages/cart.dart';

import '../../provider/cart_provider.dart';
import '../../utils/utils.dart';

class item_screen extends StatefulWidget {
  final String image, name, price,text, time;
     final int id;
  const item_screen({Key? key, required this.image,required this.id, required this.text, required this.name, required this.price, required this.time}) : super(key: key);

  @override
  State<item_screen> createState() => _item_screenState();
}

class _item_screenState extends State<item_screen> {
  DBHelper dbHelper = DBHelper();
  final firestore = FirebaseFirestore.instance.collection('Useras').snapshots();

  int count =0;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(body: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [Container(
            decoration: const BoxDecoration(
                color: Colors.black,

                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.white,
                  )
                ]
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,

          ),
          Image(
              height: 200,
              image: NetworkImage(widget.image))],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [


              GradientIcon(Icons.star, 30, LinearGradient(
                colors: [appColor1,appColor2]
              ),
              ),

              GradientIcon(Icons.star, 30, LinearGradient(
                  colors: [appColor1,appColor2]
              ),
              ),

              GradientIcon(Icons.star, 30, LinearGradient(
                  colors: [appColor1,appColor2]
              ),
              ),

              GradientIcon(Icons.star, 30, LinearGradient(
                  colors: [appColor1,appColor2]
              ),
              ),

              GradientIcon(Icons.star_border, 30, LinearGradient(
                  colors: [appColor1,appColor2]
              ),
              ),

              Expanded(

                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Rs. ' +widget.price, style: text3,)))
            ],
          ),
        ),


         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Row(
            children: [
              Text(widget.name , style: text5,),

            ],
        ),
         ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Flexible(child: Text(widget.text , style: text2,))

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text('Delivery Time', style: text3,),
              Expanded(child: Align(alignment: Alignment.centerRight,
              child: Text(widget.time + " Minuts", style: text3,),)
              )
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(

            onTap: () {

             dbHelper!.insert(
                 Cart(id: widget.id,
                     productId: widget.id.toString(),
                     productName: widget.name,
                     initialPrice: int.parse(widget.price),
                     productPrice: int.parse(widget.price),
                     quantity: 1,

                     time: int.parse(widget.time),
                     image: widget.image)).then((value) {
               Utils().toastMessage('Added to cart');
               cart.addTotalPrice(double.parse(widget.price));
               cart.addCounter();
             }).onError((error, stackTrace) {
               Utils().toastMessage('Product is already in Cart');
               print(error.toString());
             });

            },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [appColor1,appColor2]),
                  borderRadius: BorderRadius.circular(10)
                ),
                child:  Center(child: Text('Add to cart', style: text5,)),
              ),
            ),
          ),


      ],
    ),);
  }
}
