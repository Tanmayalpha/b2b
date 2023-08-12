import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  // final String name,email;
  // MyDrawer({required this.name,required this.email}){}

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(

                  gradient: LinearGradient(
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft,
                      colors: [
                        Color(0xff00AFEF), Color(0xff00469C)]

                  ),

                  color: Colors.deepPurpleAccent),
              accountName: Row(
                children: [

                  SizedBox(
                    height: 100,
                    width: 113,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Subham", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w300),),),
                  ),

                ],
              ),

              accountEmail: Text("",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w200),
                  textAlign: TextAlign.right),
              currentAccountPicture: CircleAvatar(
                //  backgroundImage:AssetImage("images/image/undraw_Login_re_4vu2.png"),
              ),
            ),
          ),

          Column(
            children: [
              Container(
                height: 55,
                width: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                      colors: [
                        Color(0xff00AFEF), Color(0xffE8EAF6)]

                  ),
                ),


                //  color:Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 50,),
                    Padding(padding: EdgeInsets.only(left: 20)
                    ),
                    Text("Home", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              Container(
                height: 55,
                width: 320,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)
                    ),
                    InkWell(
                      child: Text("Terms & Condition", style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        print("Shubham");
                      },
                    ),

                  ],
                ),
              ),

              Container(
                height: 55,
                width: 320,
                color: Colors.white,
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      onTap: () {
                        print("-------------------------------");
                        // LoginPage instance=LoginPage();
                        // instance. Demo1();

                        // print("$widget.name");
                        // print("$email");
                        // print("{$LoginPage.Demo().sourabh}");
                      },
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)
                    ),
                    Text("Privacy Policy", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              Container(
                height: 55,
                width: 320,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)
                    ),
                    Text("Rate Us", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],),
    );
  }
}
