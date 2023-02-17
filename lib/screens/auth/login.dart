import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rebeca_delight/constants/contstants.dart';
import 'package:rebeca_delight/provider/login_provider.dart';
import 'package:rebeca_delight/screens/home_screen.dart';
import 'package:rebeca_delight/utils/utils.dart';
import '../../constants/reusable.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var _passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    _user = googleUser;

    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }


  bool isvalid = false;

  void Validate(String email) {
    isvalid = EmailValidator.validate(email);
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<loadingProvider>(context, listen: false);
    print('hello');
    return Scaffold(
      backgroundColor: Color(0xff241e20),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Image(image: AssetImage('images/logo2.png'),),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Rebecca's Delight", style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold,
                    fontSize: 40),),
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
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    controller: emailcontroller,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.phone, color: appColor1,),
                                        hintText: 'Enter your Email',
                                        hintStyle: TextStyle(
                                            color: Colors.black54
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          borderSide: BorderSide(
                                              color: appColor2, width: 3),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            borderSide: BorderSide(
                                                color: appColor1, width: 3)
                                        )

                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    controller: passwordcontroller,
                                    obscureText: !_passwordVisible,//
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.lock, color: appColor2,),
                                        hintText: 'Password',
                                        // helperText: 'Password must contain numbers, alpha',
                                        hintStyle: TextStyle(
                                            color: Colors.black54
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          borderSide: BorderSide(
                                              color: appColor1, width: 3),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            borderSide: BorderSide(
                                                color: appColor2, width: 3)
                                        ),

                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColorDark,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      ),


                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            )),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text('Forgot Paasword?'),
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),

                            child: Consumer<loadingProvider>(
                              builder: (context, value, child) {
                                return ButtonRound(text: 'Log In',
                                    loading: provider.loading,
                                    ontap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        Validate(emailcontroller.text);
                                        if (isvalid == true) {
                                          provider.loaded(true);

                                          _auth.signInWithEmailAndPassword(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text
                                                  .toString()).then((
                                              value) async {
                                            provider.loaded(false);
                                            Utils().toastMessage(
                                                value.user!.email.toString());
                                            Navigator.pushReplacementNamed(
                                                context, '/home');
                                          }).onError((error, stackTrace) {
                                            provider.loaded(false);
                                            Utils().toastMessage(
                                                error.toString());
                                          });
                                        }
                                        else {
                                          Utils().toastMessage(
                                              "Enter Valid Email");
                                        }
                                      }
                                    });
                              },

                            )

                        ),
                        const Divider(
                          thickness: 3,
                          height: 10,


                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  googleLogin();
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'images/google.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  try{
                                    final fbloginresult = await FacebookAuth.instance.login();
                                    final userData = await FacebookAuth.instance.getUserData();
                                    final fbauthcredential = FacebookAuthProvider.credential(fbloginresult.accessToken!.token);
                                    await FirebaseAuth.instance.signInWithCredential(fbauthcredential);
                                    await FirebaseFirestore.instance.collection('userss').add({
                                      'email' : userData['email'],
                                      'imageUrl': userData['picture']['data']['url'],
                                      'name': userData['name'], });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home_Screen()));
                                  } on FirebaseAuthException catch(e){
                                    var content = '';
                                    switch(e.code){
                                      case 'account-exists-with-different-credential':
                                        content = 'This accouint exists with different sign in provider';
                                        break; }
                                    showDialog(context: context, builder: (context)=> AlertDialog(
                                      title: const Text(' log in failed'),
                                      content: Text(content),
                                      actions: [TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                          child: const Text('ok'))],
                                    ));
                                  } finally{
                                    setState(() {
                                      }
                                    );
                                  }


                                  // FacebookAuth.instance.login(
                                  //     permissions: ["public_profile", "email"])
                                  //     .then((value) async {
                                  //   setState(() {
                                  //     isLoggedIn = true;
                                  //   });
                                  //   final LoginResult result = await FacebookAuth
                                  //       .instance.login();
                                  //   if (result.status == LoginStatus.success) {
                                  //     final AccessToken accessToken = result
                                  //         .accessToken!;
                                  //   }
                                  //
                                  //   final userData = await FacebookAuth.i
                                  //       .getUserData();
                                  //   if (kDebugMode) {
                                  //     print(
                                  //         'Your fb name : ${userData['name']}');
                                  //     print(
                                  //         'Your fb email : ${userData['email']}');
                                  //     print(
                                  //         'Your fb photo : ${userData['picture']['data']['url']}');
                                  //   }
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               Home_Screen()));
                                  // });
                                  //

                                   // signInWithFacebook();
                                  // setState(() {
                                  //
                                  // });
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                  AssetImage('images/facebook.png'),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/loginwithphone');
                                  },
                                  child: const CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.call, size: 50,))
                              ),

                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25, bottom: 0, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text("Don't Have an account?", style: text2,),
                              SizedBox(width: 5,),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/signup');
                                },
                                child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [appColor1, appColor2]),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                        child: Text('Sign Up', style: text2))),
                              ),

                            ],

                          ),
                        ),


                      ],

                    )
                ),


              ),


            ],
          ),
        ),
      ),
    );
  }

//   Future<UserCredential> signInWithFacebook() async {
//     // Trigger the sign-in flow
//     final LoginResult loginResult = await FacebookAuth.instance.login(
//       permissions: [
//         'email', 'public_profile', 'user_birthday'
//       ]
//     );
//
//     // Create a credential from the access token
//     final OAuthCredential facebookAuthCredential =  FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//     final userData = await FacebookAuth.instance.getUserData().then((value) => {
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()))
//
//     }
//     );
//
//
//
//     // Once signed in, return the UserCredential
//     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   }
 }