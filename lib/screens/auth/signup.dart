// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebeca_delight/constants/contstants.dart';
import 'package:rebeca_delight/constants/reusable.dart';
import 'package:rebeca_delight/screens/test.dart';
import 'package:rebeca_delight/utils/utils.dart';

import '../../provider/signuo_provider.dart';

class Signup extends StatefulWidget {
   const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance ;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


   final firestore = FirebaseFirestore.instance.collection('Users');
   //final databaseRef =FirebaseDatabase.instance.ref('Post');
  TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }
 bool isvalid = false;
  void Validate(String email){
     isvalid = EmailValidator.validate(email);

  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context, listen: false);
    print('hello');
    return
      Scaffold(
        backgroundColor: Color(0xff241e20),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [

                Image(image: AssetImage('images/logo2.png'),),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
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

                                  // textfiled for name

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                      controller: namecontroller,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(Icons.person, color: appColor1,),
                                          hintText: 'Name',
                                          hintStyle: TextStyle(
                                              color: Colors.black54
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: appColor2, width: 3),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: appColor1, width: 3)
                                          )

                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Must enter name";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  // textfiled for email
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextFormField(
                                      controller: emailcontroller,
                                      style: const TextStyle(color: Colors.black, fontSize: 20),
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(Icons.phone, color: appColor1,),
                                          hintText: 'Email or phone number',
                                          hintStyle: const TextStyle(
                                              color: Colors.black54
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: appColor2, width: 3),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: appColor1, width: 3)
                                          )

                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Enter Your Email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  // textfiled for password
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                                    child: TextFormField(
                                      obscureText: true,
                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                      controller: passwordcontroller,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(Icons.lock, color: appColor2,),
                                          suffixIcon: Icon(Icons.remove_red_eye, color: appColor1,),
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.black54
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: appColor1, width: 3),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide(color: appColor2, width: 3)
                                          )

                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return ' Enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                ],)),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),


                              child: Consumer<SignupProvider>(builder: (context, value, child){
                                return ButtonRound(text: 'Sign Up', loading: provider.loading, ontap: () async {
                                  if(_formKey.currentState!.validate()){
                                    provider.Loading(true);
                                    var id = DateTime.now().millisecondsSinceEpoch.toString();
                                    firestore.doc(id).set({
                                      'id' : id,
                                      'Username': namecontroller.text.toString()
                                    }).then((value) {

                                      Validate(emailcontroller.text);
                                      if(isvalid == true ){

                                        provider.Loading(true);


                                        _auth.createUserWithEmailAndPassword(
                                            email: emailcontroller.text.toString(),
                                            password: passwordcontroller.text.toString()).then((value) async {
                                          Utils().toastMessage("Account created");
                                          provider.Loading(false);

                                          Navigator.pushReplacementNamed(context, '/login');
                                        }).onError((error, stackTrace) {
                                          Utils().toastMessage(error.toString());
                                          provider.Loading(false);
                                        });
                                      }
                                      else{
                                        Utils().toastMessage("Enter Valid email");
                                      }
                                    }).onError((error, stackTrace) {
                                      provider.Loading(false);
                                      Utils().toastMessage(error.toString());
                                    });


                                  }
                                },);
                              },)


                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,right: 25,bottom: 50, top: 0),
                            child:   Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Already have an account?", style: text2,),
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
