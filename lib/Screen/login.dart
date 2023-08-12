import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'otp_verify.dart';
import '../color.dart';

TextEditingController mobileController = new TextEditingController();
var jsonData;
var otp;
var store3;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    mobileController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
//Image
                  Image.asset('Images/bg-4.png'),
//Skip
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'main_screen');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

//B2BDiary
                  const Positioned(
                    top: 70,
                    left: 130,
                    child: Text(
                      'B2BDIARY',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),

//Center Container
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 300, top: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Theme.of(context).focusColor),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.9))
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
//Welcome
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                'Welcome!',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),

//Login to continue
                            const Text(
                              'Login to continue',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),

//Text Input Number

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 100, left: 30, bottom: 50, right: 30),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  controller: mobileController,
                                  // maxLength: 10,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    hintText: '+911234567890',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 10) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ),
//Send otp

                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                    postData(context);
                                  }

                                  if (kDebugMode) {
                                    print("Uploaded");
                                  }
                                },
                                child: Container(
                                  width: 220,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    "Send OTP",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ), //Padding(
//
                          ],
                        ),
                      ),
                    ),
                  ),

                  //  Free Registration or Don't have an account
                  Container(
                    padding: EdgeInsets.only(left: 140, top: 620),
                    child: const Text(
                      'Free Registration',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
//Don't have an account
                  Container(
                      padding: EdgeInsets.only(left: 100, top: 630),
                      child: Row(
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

postData(BuildContext context) async {
  Uri url =
      Uri.parse("https://developmentalphawizz.com/B2B/seller/app/v1/api/login");
  var data = {
    'mobile': mobileController.text,
  };

  var post = await http.post(url, body: data);
  try {
    if (post.statusCode == 200) {
      jsonData = jsonDecode(post.body);
      print(jsonData['error']);
      if (jsonData['error'] == false) {
        // print("${mobileController.text}");
        otp = jsonData['otp'];
        // print(jsonData['data'][0]['username']);
        //  print("trueeeeeeeeeeeeeeeeeeeee");
        print(otp);
        jsonData == null
            ? CircularProgressIndicator()
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpVerify(
                          currentOtp: '${otp}',
                          mobileNo: '${mobileController.text}',
                        )));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => OtpVerify()));
        Fluttertoast.showToast(
          msg: jsonData['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(msg: jsonData['message']);
      }
      // }else {
      //   print('field');
    }
    print("${jsonData.message}");
    print("${mobileController.text}===========");

    //  print("Data uploaded");
  } catch (e) {
    print(e.toString());
  }
}

