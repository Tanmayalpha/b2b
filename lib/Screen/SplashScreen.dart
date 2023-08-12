
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
import 'login.dart';

String? finalOtp;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigatetohome();
    getValidation();
  }
  Future getValidation()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedOtp= sharedPreferences.getString('id');

      finalOtp = obtainedOtp;
    _navigatetohome();

  }

  _navigatetohome() async{
    await Future.delayed(const Duration(seconds: 2),(){});
  // Get.to(finalOtp==null?LoginPage():DetailPage());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> finalOtp==null ? LoginPage(): B2BHome()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                Image.asset('Images/Splash.png',fit: BoxFit.cover,

              ),
      ),
            Container(
              child: Center(
              child: Text(''
                  'B2BDIARY',
              style: TextStyle(color: Colors.white,fontSize: 28,
              ),
              ),
          ),
            ),
      ],
        ),
      ),
    );
  }
}
