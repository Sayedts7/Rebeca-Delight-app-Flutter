import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebeca_delight/firebase_services/splash_services.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  SplashServices splashservices = SplashServices();
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservices.isLogin(context);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff241e20),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: Image(image: AssetImage('images/logo2.png'),)),
          SizedBox(height: 30),
          Text("Rebeca's Delight", style: TextStyle(color:Colors.white, fontFamily: 'DancingScript', fontWeight: FontWeight.bold, fontSize: 40),)
        ],
      ),
    );
  }
}
