import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/PrivacyPolicy.dart';
import 'package:b2b/Screen/login.dart';
import 'package:b2b/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

getDrawer(BuildContext context, String name, String email, String profile) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width / 1.3,
    child: ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [colors.primary, colors.primary],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // main
            children: [
               CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  profile,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // userModel == null || userModel!.data == null
              //     ? SizedBox.shrink()
              //     :
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children:  [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                     SizedBox(
                      width: 150,
                      child: Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    /*getprofile?.user?.userData?.first.placeName == null ? Text("Vijay Nagar",style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal),) : Text("${getprofile?.user?.userData?.first.placeName}",style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                    )*/
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                colors.white,
                colors.primary,
              ],
            ),
          ),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.person)
            ),
            title: const Text(
              ' My Profile',
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (Context) => Container()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              // );
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.home),
          title: const Text(
            'Home',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => B2BHome()),
            );
          },
        ),

          /*ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset(
              "assets/images/BOOKING.png",
              // color: colors.black54,
              height: 23,
              width: 30,
            ),
          ),
          title: Text(
            'Booking',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>BookingScreen()),
            );
          },
        ),*/

        /*ListTile(
          leading: Image.asset(
            "assets/images/SUBSCRIPTION PLAN.png",
            // color: colors.black54,
            height: 40,
            width: 40,
          ),
          title: Text(
            'Subscription Plan',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionPlan()),
            );
          },
        )*/
       /* ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Image.asset(
              "assets/images/HISTORY.png",
              // color: colors.black54,
              height: 26,
              width: 30,
            ),
          ),
          title: Text(
            'History',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => History()),
            );
          },
        ),*/
        /*ListTile(
          leading: Image.asset(
            "assets/images/WISHLIST.png",
            // color: colors.black54,
            height: 40,
            width: 40,
          ),
          title: Text(
            'Wishlist',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Wishlist()),
            );
          },
        ),*/
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Change Password',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Container()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text(
            'Terms &Conditions',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Container()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text(
            'Privacy Policy',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicy()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text(
            'Share App',
          ),
          onTap: () {
            //share();
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => HomeScreen()),
            //   );
          },
        ),
        /*ListTile(
          leading: Image.asset(
            "assets/images/DELETE.png",
            // color: colors.black54,
            height: 25,
            width: 40,
          ),
          title: Text(
            'Delete Account',
          ),
          onTap: () {
            deleteAccountDailog();
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => HomeScreen()),
            //   );
          },
        ),*/
        ListTile(
          leading: Icon(Icons.logout),
          title: const Text(
            'Sign Out',
          ),
          onTap: () async {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Sign out"),
                    content: const Text("Are  sure to sign out from app now?"),
                    actions: <Widget>[
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(primary: colors.primary),
                        child: const Text("YES"),
                        onPressed: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                            prefs.clear();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(primary: colors.primary),
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          },
        ),
      ],
    ),
  );
}