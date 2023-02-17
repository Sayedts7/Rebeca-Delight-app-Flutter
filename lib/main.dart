
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rebeca_delight/provider/cart_provider.dart';
import 'package:rebeca_delight/provider/login_provider.dart';
import 'package:rebeca_delight/provider/signuo_provider.dart';
import 'package:rebeca_delight/screens/Splash_screen.dart';
import 'package:rebeca_delight/screens/auth/loginwithphone.dart';
import 'package:rebeca_delight/screens/category/biryanicategory.dart';
import 'package:rebeca_delight/screens/category/burger_categoires.dart';
import 'package:rebeca_delight/screens/category/donut_category.dart';
import 'package:rebeca_delight/screens/category/pizza_category.dart';


import 'package:rebeca_delight/screens/home_screen.dart';
import 'package:rebeca_delight/screens/items_pages/item_screen.dart';
import 'package:rebeca_delight/screens/maps/search_map.dart';
import 'package:rebeca_delight/screens/profile.dart';
import 'package:rebeca_delight/screens/auth/signup.dart';

import 'screens/auth/login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
     // statusBarColor: Colors.transparent,
   //   statusBarIconBrightness: Brightness.dark,
    //));
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => CartProvider(),),

        ChangeNotifierProvider( create: (_) => loadingProvider(),),

          ChangeNotifierProvider( create: (_) => SignupProvider(),),

        ],
    child: Builder(builder: (BuildContext context) {
      return MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
          fontFamily: 'Montserrat-ExtraBoldItalic|',


        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/login': (context) => const login(),
          '/loginwithphone': (context) => const LoginWithPhone(),
          //'/verifycode': (context)=> const VerifyCodeScreen(),
          '/signup': (context) => const Signup(),
          '/home': (context) => const Home_Screen(),
          // '/location': (context)=> location(lat: '', lang: "",),
          '/cBurgers': (context) => const category(),
          '/cBiryani': (context) => const categoryB(),
          '/cPizza': (context) => const Pizaa_category(),
          '/cDonut': (context) => const Category_donut(),
          '/items': (context) => const item_screen(image: '',
              text: '',
              name: '',
              price: '',
              time: '', id: 1,),
          '/profile': (context) => Profile(),
          '/Searchmap': (context) => SearchMap(),
        },
      );
    }
    ), );
  }
}

