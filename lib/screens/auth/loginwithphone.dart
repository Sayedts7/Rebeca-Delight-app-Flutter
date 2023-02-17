import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rebeca_delight/constants/contstants.dart';
import 'package:rebeca_delight/constants/reusable.dart';
import 'package:rebeca_delight/screens/auth/verify_code.dart';
import 'package:rebeca_delight/utils/utils.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  var Ccode;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance ;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phonecontroller.dispose();

  }


  void isLogin(){
      setState(() {
        loading= true;
      });
      _auth.verifyPhoneNumber(
        phoneNumber: Ccode+phonecontroller.text,
          verificationCompleted: (_){
            setState(() {
              loading= false;
            });
          },

          verificationFailed:(e) {
          Utils().toastMessage(e.toString());
          print(phonecontroller);
          setState(() {
            loading= false;
          });
          },

          codeSent: (String verification, int? token) {
            print(phonecontroller);
            setState(() {
              loading= false;
            });
    Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(
      VerificationId: verification, phonenumber: phonecontroller.text, )));
            print(phonecontroller);
          },

          codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
          print(phonecontroller);
          setState(() {
            loading= false;
          });
          });
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xff241e20),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Image(image: AssetImage('images/logo2.png'),),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text("Rebecca's Delight", style: TextStyle(color:Colors.white, fontFamily: 'DancingScript', fontWeight: FontWeight.bold, fontSize: 40),),
                ),

                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: IntlPhoneField(
                                      initialCountryCode: 'PK',
                                      keyboardType: TextInputType.phone,
                                      controller: phonecontroller,
                                      style: const TextStyle(color: Colors.black, fontSize: 20),
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey,
                                          filled: true,
                                          prefixIcon: const Icon(Icons.phone, color: appColor1,),
                                          hintText: 'Enter phone number',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: appColor2, width: 3),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: appColor1, width: 3)
                                          ),

                                      ),
                                      onChanged: (phone) {
                                        Ccode = phone.countryCode;
                                      },

                                    ),
                                  ),


                                ],)),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),


                            child: ButtonRound(text: 'Login', loading: loading, ontap: () async {
                              if(_formKey.currentState!.validate()){
                                isLogin();

                              }
                            },),


                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,right: 25,bottom: 50, top: 30),
                            child:   Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Login with email?", style: text2,),
                                SizedBox(width: 5,),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [appColor1, appColor2]),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child:  Center(child: Text('Login', style: text2))),
                                ),

                              ],

                            ),
                          )

                        ],
                      )),

                ),



              ],
            ),
          ),
        ),
      );
  }
}
