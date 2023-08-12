import 'dart:convert';
import 'package:b2b/widgets/multi_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../color.dart';
import 'detail.dart';

var jsonData;
var store;
// final _formKey = GlobalKey<FormState>();

TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController emailController = TextEditingController();

String? name;
String? mobile;
String? email;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// final _formKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    nameController.text = '';
    emailController.text = '';
    mobileController.text = '';

    // TODO: implement initState
    super.initState();
  }

  // void dispose() {
  //   nameController.dispose();
  //   nameController.clear();
  //   super.dispose();
  // }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
//Image
                  Image.asset('Images/bg-4.png'),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 300, top: 150),
                    child: Container(
                      height: 510,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.9))
                        ],
                        border: Border.all(color: Theme.of(context).focusColor),
                      ),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              const Center(
                                child: Text(
                                  'SignUp to continue',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
//Text Input Field
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 60, left: 30, bottom: 10, right: 30),
                                child: TextFormField(
                                  controller: nameController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Owner Name',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        RegExp(r'^[0-9]').hasMatch(value)) {
                                      return 'Owner Name is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, bottom: 10, right: 30),
                                child: TextFormField(
                                  controller: mobileController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,

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
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value!.length < 10) {
                                      return 'Mobile is required';
                                    }
                                    return null;
                                  },

                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9{10}]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, bottom: 50, right: 30),
                                child: TextFormField(
                                  controller: emailController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.emailAddress,

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
                                    hintText: 'Email ID',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.email),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z||A-Z||0-9]+@[a-z]+\.[a-z]{2,3}')
                                            .hasMatch(value)) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: 190,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: colors.primary,
                                    ),
                                    onPressed: () {
                                      name = nameController.text;
                                      mobile = mobileController.text;
                                      email = emailController.text;
                                      if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Processing Data')),
                                        );
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      userName:
                                                          nameController.text,
                                                      userMobile:
                                                          mobileController.text,
                                                      userEmail: emailController.text,
                                                    )));
                                      }
                                      // Navigator.pushNamed(context, 'detail');
                                    },
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 100, top: 650),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: const Text(
                              'Log In',
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
