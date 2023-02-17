import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rebeca_delight/constants/reusable.dart';

import '../../constants/contstants.dart';
import '../items_pages/item_screen.dart';
import '../maps/search_map.dart';

class categoryB extends StatefulWidget {
  const categoryB({Key? key}) : super(key: key);

  @override
  State<categoryB> createState() => _categoryBState();
}

class _categoryBState extends State<categoryB> {

  final firestore = FirebaseFirestore.instance.collection('Useras').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [appColor1, appColor2],
              ),
            ),
          ),

          title: Text(
            "Rebecca's Delight",
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            Icon(Icons.notifications),
            SizedBox(
              width: 15,
            )
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
                  'Taimoor',
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
              title: const Text(
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
              onTap: () async {

                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/biryani.png',
                      text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                      name: 'Special Biryani', price: '500', time: '20 minutes', id: 1,)));
                },
                child: const Category_Container(
                    name: 'Biryani',
                    ratingC: '(102)',
                    price: '550',
                    image: 'images/biryaniwide.png',
                    rating: '4.7',
                    time: '30',
                    categ: ' Pakistani',
                    off: 'Flat 20 % off'),
                // StreamBuilder<QuerySnapshot>(
                //     stream: firestore,
                //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                //       if(snapshot.connectionState == ConnectionState.waiting){
                //         return CircularProgressIndicator();
                //       }
                //       if(snapshot.hasError)
                //         return Text('Error');
                //       return Expanded(
                //         child: ListView.builder(
                //             itemCount: snapshot.data!.docs.length,
                //             itemBuilder: (context, index){
                //               return
                //             }),
                //       );
                //     }),

              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/frid.png',
                      text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                      name: 'Sada Biryani', price: '300', time: '20 minutes', id: 1,)));
                },
                child: const Category_Container(
                    name: 'Sada Rice',
                    ratingC: '(122)',
                    price: '350',
                    image: 'images/biryaniwide.png',
                    rating: '4.4',
                    time: '30',
                    categ: ' Pakistani',
                    off: 'Flat 30 % off'),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const item_screen(image: 'images/fried.png',
                      text: 'Best burger in the town. Must try, Best burger in the town. Must try, Best burger in the town. Must try',
                      name: 'Bombai Biryani', price: '500', time: '20 minutes', id: 1,)));
                },
                child: const Category_Container(
                    name: 'Bombai Buryani',
                    ratingC: '(100)',
                    price: '650',
                    image: 'images/biryaniwide.png',
                    rating: '4.6',
                    time: '40',
                    categ: ' Indian',
                    off: 'Flat 40 % off'),
              ),

            ],
          ),
        ));
  }
}









