import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rebeca_delight/cartModel/cart_model.dart';
import 'package:rebeca_delight/cartModel/cart_screen.dart';
import 'package:rebeca_delight/cartModel/db_helper.dart';
import 'package:rebeca_delight/constants/contstants.dart';
import 'package:rebeca_delight/constants/reusable.dart';
import 'package:rebeca_delight/provider/cart_provider.dart';
import 'package:rebeca_delight/screens/maps/search_map.dart';
import 'package:rebeca_delight/screens/test.dart';
import 'package:rebeca_delight/utils/utils.dart';

import 'items_pages/item_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();

  DBHelper? dbHelper = DBHelper();
  final googleSignIn = GoogleSignIn();

  final _databaseRef = FirebaseDatabase.instance.ref('Post').child('username');
  final firestore = FirebaseFirestore.instance.collection('Food_Items').snapshots();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [appColor1, appColor2],
              ),
            ),
          ),

          title: const Text(
            "Rebecca's Delight",
            style: TextStyle(fontSize: 25),
          ),
          actions:  [
            const Icon(Icons.notifications),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),
            Center(
              child: Badge(
                badgeColor: Colors.black,
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child){
                      return Text(value.getCounter().toString());
                    },
                  ),

                child:  Icon(Icons.shopping_bag_outlined),
              ),
            ),

            SizedBox(
                width: MediaQuery.of(context).size.width*0.05,)
          ],
          // automaticallyImplyLeading: false,
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            UserAccountsDrawerHeader(
              onDetailsPressed: (){
                Navigator.pushNamed(context, '/profile');
              },
                decoration: const BoxDecoration(
                  color: appColor1,
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('images/dp.png'),
                ),

                accountName: Text(
                auth.currentUser!.email.toString(),
                  style: text3,
                ),
                accountEmail: null),
             ListTile(
              leading: const Icon(
                Icons.person,
                color: appColor2,
              ),
              title: const Text(
                'Profile',
                style: textSimpleRobo,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            Divider(
              color: appColor1,
            ),
            const ListTile(
              leading: Icon(
                Icons.receipt,
                color: appColor2,
              ),
              title: Text(
                'Orders',
                style: textSimpleRobo,
              ),
            ),
            const Divider(
              color: appColor1,
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on,
                color: appColor2,
              ),
              title: Text(
                'Addresses',
                style: textSimpleRobo,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchMap()));
              },
            ),
            Divider(
              color: appColor1,
            ),
            const ListTile(
              leading: Icon(
                Icons.emoji_events,
                color: appColor2,
              ),
              title: Text(
                'Rewards',
                style: textSimpleRobo,
              ),
            ),
            Divider(
              color: appColor1,
            ),
            const ListTile(
              leading: Icon(
                Icons.help,
                color: appColor2,
              ),
              title: Text(
                'Help Center',
                style: textSimpleRobo,
              ),
            ),
            const Divider(
              color: appColor1,
            ),
             ListTile(
              title: Text(
                'Settings',
                style: textSimpleRobo,
              ),
              onTap: (){
             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> test()));
              },
            ),
            ListTile(
              title: const Text(
                'Log out',
                style: textSimpleRobo,
              ),
              onTap: () {
                auth.signOut();
                FacebookAuth.instance.logOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextFormField(
                        onChanged: (value){
                          setState(() {

                          });
                        },
                        controller: searchController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(

                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: const Icon(
                              Icons.search,
                              color: appColor2,
                            ),
                            hintText: 'What do you wanna eat?',
                            hintStyle: TextStyle(color: Colors.black54),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: appColor1, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: appColor2, width: 3))),
                      ),
                    ),
                    IconButton(onPressed: (){

                    }, icon: const Icon(Icons.tune, size: 40,)),
                  ],
                ),
             searchController.text.isEmpty ?
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Padding(
                   padding: EdgeInsets.symmetric(vertical: 15.0),
                   child: Text(
                     'Categories',
                     style: text4,
                   ),
                 ),

                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: [
                       InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, '/cBurgers');
                         },
                         child: const Reusable_Con1(
                           image: 'images/burger.png',
                           heading: 'Burgers',
                         ),
                       ),
                       InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, '/cBiryani');
                         },
                         child: const Reusable_Con1(
                           image: 'images/biryani.png',
                           heading: 'Rice',
                         ),
                       ),
                       InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, '/cPizza');
                         },
                         child: const Reusable_Con1(
                           image: 'images/pizza.png',
                           heading: 'Pizza',
                         ),
                       ),
                       InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, '/cDonut');
                         },
                         child: const Reusable_Con1(
                           image: 'images/donut.png',
                           heading: 'Dounuts',
                         ),
                       ),
                       const Reusable_Con1(
                         image: 'images/fried.png',
                         heading: 'Whatever',
                       ),
                       InkWell(
                         onTap: () {
                           //Navigator.push(context, MaterialPageRoute(builder: (context)=>()));
                         },
                         child: const Reusable_Con1(
                           image: 'images/ice.png',
                           heading: 'Ice Cream',
                         ),
                       ),
                     ],
                   ),
                 ),
                 const Padding(
                   padding: EdgeInsets.only(top: 15.0, bottom: 15),
                   child: Text(
                     'Popular',
                     style: text4,
                   ),
                 ),
                 StreamBuilder<QuerySnapshot>(
                     stream: firestore,
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                       if(snapshot.connectionState == ConnectionState.waiting){
                         return CircularProgressIndicator();
                       }
                       if(snapshot.hasError)
                         return Text('Error');
                       return SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Container(
                           height: 300,
                           child: ListView.builder(
                               physics: NeverScrollableScrollPhysics(),
                               scrollDirection: Axis.horizontal,
                               shrinkWrap: true,
                               itemCount: snapshot.data!.docs.length,
                               itemBuilder: (context, index){
                                 String name = snapshot.data!.docs[index]['name'];
                                 String category = snapshot.data!.docs[index]['category'].toString();
                                 if(searchController.text.isEmpty)
                                 {
                                   return InkWell(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                                         image: snapshot.data!.docs[index]['image'].toString(),
                                         text: snapshot.data!.docs[index]['description'].toString(),
                                         name: snapshot.data!.docs[index]['name'].toString(),
                                         price: snapshot.data!.docs[index]['price'].toString(),
                                         time: snapshot.data!.docs[index]['delivery_time'].toString(),
                                         id: index,)));
                                     },
                                     child:   category.toLowerCase().contains('popular')? LargeContainer(
                                       image: snapshot.data!.docs[index]['image'].toString(),
                                       name: snapshot.data!.docs[index]['name'].toString(),
                                       english:
                                       snapshot.data!.docs[index]['description'].toString(),
                                       price: snapshot.data!.docs[index]['price'].toString(),
                                       rating: "4.2  (100+)",
                                       genre:  snapshot.data!.docs[index]['category'].toString(),

                                       // ontap: () {
                                       //
                                       //   dbHelper!.insert(
                                       //       Cart(
                                       //           id: index,
                                       //           productId: index.toString(),
                                       //           productName: snapshot.data!.docs[index]['name'].toString(),
                                       //           initialPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                       //           productPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                       //           quantity: 1,
                                       //           time: int.parse(snapshot.data!.docs[index]['delivery_time']),
                                       //
                                       //           image: snapshot.data!.docs[index]['image'].toString())
                                       //   ).then((value) {
                                       //     Utils().toastMessage('Added to cart');
                                       //     cart.addTotalPrice(double.parse(snapshot.data!.docs[index]['price'].toString(),));
                                       //     cart.addCounter();
                                       //   }).onError((error, stackTrace) {
                                       //     Utils().toastMessage('Product is already in Cart');
                                       //     print(error.toString());
                                       //   });
                                       // },
                                     ) : Text(''),
                                   );
                                 }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                   return InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                                           image: snapshot.data!.docs[index]['image'].toString(),
                                           text: snapshot.data!.docs[index]['description'].toString(),
                                           name: snapshot.data!.docs[index]['name'].toString(),
                                           price: snapshot.data!.docs[index]['price'].toString(),
                                           time: snapshot.data!.docs[index]['delivery_time'].toString(),
                                           id: index,)));
                                       },
                                       child:    category.toLowerCase().contains('popular')? LargeContainer(
                                         image: snapshot.data!.docs[index]['image'].toString(),
                                         name: snapshot.data!.docs[index]['name'].toString(),
                                         english:
                                         snapshot.data!.docs[index]['description'].toString(),
                                         price: snapshot.data!.docs[index]['price'].toString(),
                                         rating: "4.2  (100+)", genre: 'popular',

                                         // ontap: () {
                                         //
                                         //   dbHelper!.insert(
                                         //       Cart(
                                         //           id: index,
                                         //           productId: index.toString(),
                                         //           productName: snapshot.data!.docs[index]['name'].toString(),
                                         //           initialPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                         //           productPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                         //           quantity: 1,
                                         //           time: int.parse(snapshot.data!.docs[index]['delivery_time']),
                                         //
                                         //           image: snapshot.data!.docs[index]['image'].toString())
                                         //   ).then((value) {
                                         //     Utils().toastMessage('Added to cart');
                                         //     cart.addTotalPrice(double.parse(snapshot.data!.docs[index]['price'].toString(),));
                                         //     cart.addCounter();
                                         //   }).onError((error, stackTrace) {
                                         //     Utils().toastMessage('Product is already in Cart');
                                         //     print(error.toString());
                                         //   });
                                         // },
                                       ) : Text('')
                                   );
                                 }else{
                                   return Container();
                                 }



                               }),
                         ),
                       );
                     }),

                 // SingleChildScrollView(
                 //   scrollDirection: Axis.horizontal,
                 //   child: Row(
                 //     children:  [
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(image: 'images/steek.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Steek', price: '1500', time: '35 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/steek.png',
                 //           name: 'Steek',
                 //           genre: 'Pakistani',
                 //           english:
                 //               'Bus kya bataon yar, aise biryani khai nahi hogi khabi ap na',
                 //           price: 'Rs. 1500    ',
                 //           rating: "4.7  (100+)",
                 //         ),
                 //       ),
                 //
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/Biryani.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Biryani', price: '300', time: '25 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/biryani.png',
                 //           name: 'Biryani',
                 //           genre: 'Pakistani',
                 //           english:
                 //               'Bus kya bataon yar, aise biryani khai nahi hogi khabi ap na',
                 //           price: 'Rs. 300    ',
                 //           rating: "4.5  (100+)",
                 //         ),
                 //       ),
                 //
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/frid.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Sada Rice', price: '100', time: '25 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/frid.png',
                 //           name: 'Sada Rice',
                 //           genre: 'Pakistani',
                 //           english:
                 //               'Bus kya bataon yar, aise biryani khai nahi hogi khabi ap na',
                 //           price: 'Rs. 100    ',
                 //           rating: "4.7  (100+)",
                 //         ),
                 //       ),
                 //
                 //
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/fried.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Mixed', price: '400', time: '15 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/fried.png',
                 //           name: 'Mixed',
                 //           genre: 'Pakistani',
                 //           english:
                 //               'Bus kya bataon yar, aise biryani khai nahi hogi khabi ap na',
                 //           price: 'Rs. 400    ',
                 //           rating: "4.5  (100+)",
                 //         ),
                 //       ),
                 //
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/burger p.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Chapli Burger', price: '250', time: '35 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/burger.png',
                 //           name: 'Chapli Burger',
                 //           genre: 'Angrezi',
                 //           english:
                 //               ' Yara bus sa darta owaim kana, deer mazidar d, sta ba yaqeen na razi',
                 //           price: 'Rs. 250    ',
                 //           rating: '3.6  (100+)',
                 //         ),
                 //       ),
                 //
                 //       InkWell(
                 //         onTap: (){
                 //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/beef.png',
                 //               text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //               name: 'Beef Biryani', price: '500', time: '40 minutes', id: 1,)));
                 //         },
                 //         child: const LargeContainer(
                 //           image: 'images/beef.png',
                 //           name: 'Beef Biryani',
                 //           genre: 'Pakistani',
                 //           english:
                 //               'Bus kya bataon yar, aise biryani khai nahi hogi khabi ap na',
                 //           price: 'Rs. 500    ',
                 //           rating: "4.2  (100+)",
                 //         ),
                 //       ),
                 //     ],
                 //   ),
                 // ),
                 const Padding(
                   padding: EdgeInsets.symmetric(vertical: 10.0),
                   child: Text(
                     "Extra Chezain",
                     style: text4,
                   ),
                 ),
                 // Column(
                 //   children: [
                 //     InkWell(
                 //       onTap: (){
                 //         Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(image: 'images/karahi r.png',
                 //             text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //             name: 'Chicken Karahi', price: '1100', time: '55 minutes')));
                 //       },
                 //       child: wideContainer(
                 //         image: 'images/karahi.jpg',
                 //         name: 'Chicken Karahi',
                 //         english:
                 //         'Bus kya bataon yar, aise karahi khai nahi hogi khabi ap na',
                 //         price: 'Rs. 1100    ',
                 //         rating: "4.2  (100+)",
                 //         icon: Icons.star,
                 //         icon2: Icons.star,
                 //         icon3: Icons.star_border,
                 //       ),
                 //     ),
                 //
                 //     InkWell(
                 //       onTap: (){
                 //         Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(image: 'images/chat r.png',
                 //             text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //             name: 'Channa Chat', price: '300', time: '15 minutes')));
                 //       },
                 //       child: wideContainer(
                 //         image: 'images/chat.jpg',
                 //         name: 'Channa Chat',
                 //         english:
                 //         'Bus kya bataon yar, aise chat khai nahi hogi khabi ap na',
                 //         price: 'Rs. 300    ',
                 //         rating: "3.0  (100+)",
                 //         icon: Icons.star,
                 //         icon2: Icons.star_border,
                 //         icon3: Icons.star_border,
                 //       ),
                 //     ),
                 //
                 //
                 //     InkWell(
                 //       onTap: (){
                 //         Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(image: 'images/biryani r.png',
                 //             text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //             name: 'Chicken Biryani', price: '500', time: '30 minutes')));
                 //       },
                 //       child: wideContainer(
                 //         image: 'images/biryani2.jpg',
                 //         name: 'Chicken Biryani',
                 //         english:
                 //         'Bus kya bataon yar, aise Biryani khai nahi hogi khabi ap na',
                 //         price: 'Rs. 500   ',
                 //         rating: "5.0  (100+)",
                 //         icon: Icons.star,
                 //         icon2: Icons.star,
                 //         icon3: Icons.star,
                 //       ),
                 //     ),
                 //
                 //     InkWell(
                 //       onTap: (){
                 //         Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(image: 'images/kabab r.png',
                 //             text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //             name: 'Shami Kabab', price: '600', time: '10 minutes')));
                 //       },
                 //       child: wideContainer(
                 //         image: 'images/kabab.jpg',
                 //         name: 'Shami Kabab',
                 //         english:
                 //         'Bus kya bataon yar, aise kabab khai nahi hogi khabi ap na',
                 //         price: 'Rs. 600   ',
                 //         rating: "5.0  (100+)",
                 //         icon: Icons.star,
                 //         icon2: Icons.star,
                 //         icon3: Icons.star,
                 //       ),
                 //     ),
                 //
                 //
                 //     InkWell(
                 //       onTap: (){
                 //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/samosa r.png',
                 //             text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                 //             name: 'Samosa', price: '200', time: '15 minutes')));
                 //       },
                 //       child: wideContainer(
                 //         image: 'images/samosa.jpg',
                 //         name: 'Samosa',
                 //         english:
                 //         'Bus kya bataon yar, aise samosay khai nahi hogi khabi ap na',
                 //         price: 'Rs. 200   ',
                 //         rating: "4.0  (100+)",
                 //         icon: Icons.star,
                 //         icon2: Icons.star,
                 //         icon3: Icons.star_border,
                 //       ),
                 //     ),
                 //
                 //   ],
                 // ),
                 StreamBuilder<QuerySnapshot>(
                     stream: firestore,
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                       if(snapshot.connectionState == ConnectionState.waiting){
                         return CircularProgressIndicator();
                       }
                       if(snapshot.hasError)
                         return Text('Error');
                       return SingleChildScrollView(
                         child: ListView.builder(
                             physics: NeverScrollableScrollPhysics(),
                             scrollDirection: Axis.vertical,
                             shrinkWrap: true,
                             itemCount: snapshot.data!.docs.length,
                             itemBuilder: (context, index){
                               String name = snapshot.data!.docs[index]['name'];
                               String category = snapshot.data!.docs[index]['category'].toString();
                               if(searchController.text.isEmpty)
                               {
                                 return InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                                       image: snapshot.data!.docs[index]['image'].toString(),
                                       text: snapshot.data!.docs[index]['description'].toString(),
                                       name: snapshot.data!.docs[index]['name'].toString(),
                                       price: snapshot.data!.docs[index]['price'].toString(),
                                       time: snapshot.data!.docs[index]['delivery_time'].toString(),
                                       id: index,)));
                                   },
                                   child: category.toLowerCase().contains('extra chezain')?  wideContainer(
                                     image: snapshot.data!.docs[index]['image'].toString(),
                                     name: snapshot.data!.docs[index]['name'].toString(),
                                     english:
                                     snapshot.data!.docs[index]['description'].toString(),
                                     price: snapshot.data!.docs[index]['price'].toString(),
                                     rating: "4.2  (100+)",
                                     icon: Icons.star,
                                     icon2: Icons.star,
                                     icon3: Icons.star_border,
                                     ontap: () {

                                       dbHelper!.insert(
                                           Cart(
                                               id: index,
                                               productId: index.toString(),
                                               productName: snapshot.data!.docs[index]['name'].toString(),
                                               initialPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                               productPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                               quantity: 1,
                                               time: int.parse(snapshot.data!.docs[index]['delivery_time']),

                                               image: snapshot.data!.docs[index]['image'].toString())
                                       ).then((value) {
                                         Utils().toastMessage('Added to cart');
                                         cart.addTotalPrice(double.parse(snapshot.data!.docs[index]['price'].toString(),));
                                         cart.addCounter();
                                       }).onError((error, stackTrace) {
                                         Utils().toastMessage('Product is already in Cart');
                                         print(error.toString());
                                       });
                                     },
                                   ) : Text(' '),
                                 );
                               }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                 return InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                                       image: snapshot.data!.docs[index]['image'].toString(),
                                       text: snapshot.data!.docs[index]['description'].toString(),
                                       name: snapshot.data!.docs[index]['name'].toString(),
                                       price: snapshot.data!.docs[index]['price'].toString(),
                                       time: snapshot.data!.docs[index]['delivery_time'].toString(),
                                       id: index,)));
                                   },
                                   child:  category.toLowerCase().contains('extra chezain')?  wideContainer(
                                     image: snapshot.data!.docs[index]['image'].toString(),
                                     name: snapshot.data!.docs[index]['name'].toString(),
                                     english:
                                     snapshot.data!.docs[index]['description'].toString(),
                                     price: snapshot.data!.docs[index]['price'].toString(),
                                     rating: "4.2  (100+)",
                                     icon: Icons.star,
                                     icon2: Icons.star,
                                     icon3: Icons.star_border,
                                     ontap: () {

                                       dbHelper!.insert(
                                           Cart(
                                               id: index,
                                               productId: index.toString(),
                                               productName: snapshot.data!.docs[index]['name'].toString(),
                                               initialPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                               productPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                               quantity: 1,
                                               time: int.parse(snapshot.data!.docs[index]['delivery_time']),

                                               image: snapshot.data!.docs[index]['image'].toString())
                                       ).then((value) {
                                         Utils().toastMessage('Added to cart');
                                         cart.addTotalPrice(double.parse(snapshot.data!.docs[index]['price'].toString(),));
                                         cart.addCounter();
                                       }).onError((error, stackTrace) {
                                         Utils().toastMessage('Product is already in Cart');
                                         print(error.toString());
                                       });
                                     },
                                   ) : Text(' '),
                                 );
                               }else{
                                 return Container();
                               }



                             }),
                       );
                     }),

               ],
             ) :
             StreamBuilder<QuerySnapshot>(
                 stream: firestore,
                 builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                   if(snapshot.connectionState == ConnectionState.waiting){
                     return CircularProgressIndicator();
                   }
                   if(snapshot.hasError)
                     return Text('Error');
                   return SingleChildScrollView(
                     child: ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index){
                           String name = snapshot.data!.docs[index]['name'];
                           String category = snapshot.data!.docs[index]['category'].toString();
                           if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                           {
                             return InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                                     image: snapshot.data!.docs[index]['image'].toString(),
                                     text: snapshot.data!.docs[index]['description'].toString(),
                                     name: snapshot.data!.docs[index]['name'].toString(),
                                     price: snapshot.data!.docs[index]['price'].toString(),
                                     time: snapshot.data!.docs[index]['delivery_time'].toString(),
                                     id: index,)));
                                 },
                                 child:   wideContainer(
                                   image: snapshot.data!.docs[index]['image'].toString(),
                                   name: snapshot.data!.docs[index]['name'].toString(),
                                   english:
                                   snapshot.data!.docs[index]['description'].toString(),
                                   price: snapshot.data!.docs[index]['price'].toString(),
                                   rating: "4.2  (100+)",
                                   icon: Icons.star,
                                   icon2: Icons.star,
                                   icon3: Icons.star_border,
                                   ontap: () {

                                     dbHelper!.insert(
                                         Cart(
                                             id: index,
                                             productId: index.toString(),
                                             productName: snapshot.data!.docs[index]['name'].toString(),
                                             initialPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                             productPrice: int.parse(snapshot.data!.docs[index]['price'],),
                                             quantity: 1,
                                             time: int.parse(snapshot.data!.docs[index]['delivery_time']),

                                             image: snapshot.data!.docs[index]['image'].toString())
                                     ).then((value) {
                                       Utils().toastMessage('Added to cart');
                                       cart.addTotalPrice(double.parse(snapshot.data!.docs[index]['price'].toString(),));
                                       cart.addCounter();
                                     }).onError((error, stackTrace) {
                                       Utils().toastMessage('Product is already in Cart');
                                       print(error.toString());
                                     });
                                   },
                                 )
                             );

                           }else{
                             return Container();
                           }



                         }),
                   );
                 }),


              ],
            ),

          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
          backgroundColor: Colors.white,
          child: GradientIcon(Icons.shopping_cart, 40,
              const LinearGradient(colors: [appColor1, appColor2])),
        ));
  }
}
