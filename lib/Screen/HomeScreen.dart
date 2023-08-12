import 'dart:convert';

// import 'package:anoop/Model/GetHomeCategoryModel.dart';
import 'package:b2b/Model/GetSupplierModel.dart';
import 'package:b2b/Screen/ClientScreen.dart';
import 'package:b2b/Screen/SupplierScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

// import '../Model/GetHomeCategoryModel.dart';
import '../Api.path.dart';
import '../Model/GetHomeCategoryModel.dart';
import '../Model/GetHomeCategoryModel.dart';
import '../Model/GetHomeProductsModel.dart';
import '../Model/advertiseModel.dart';
import '../Model/sliderImageModel.dart';
import '../color.dart';
import 'AllCategory.dart';
import 'AllProducts.dart';
import 'ComputerDescription.dart';
import 'DescriptionScreen.dart';
import 'FurnitrureDescription.dart';
import 'login.dart';
import 'myProfile.dart';

SliderImageModel? finalImages;

AdvertiseModel? advertise;

var homelat;
var homeLong;
var result;
var obtainedId;
var obtainedName;
var obtainedEmail;
var obtainedMobile;

var companyName;
var bussinessAddress;
var gstNumber;
var udyogNumber;
var bussinessCategory;
var country;
var state;
var district;
var area;
var pinCode;
var city;
var partnerName;
var partnerNumber;
var googleAddress;
var anyNumber;
var websiteLink;
var facebook;
var insta;
var linkdin;

var imagee;
var namee;
var emaill;
var mobilee;
var companyName2;
var bussinessAddress2;
var gstNumber2;
var udyogNumber2;
var bussinessCategory2;
var country2;
var state2;
var district2;
var area2;
var pinCode2;
var city2;
var partnerName2;
var partnerNumber2;
var googleAddress2;
var anyNumber2;
var websiteLink2;
var facebook2;
var insta2;
var linkdin2;


String? product_name;
String? product_price;
String? product_loc;
String? product_image;

var profileStore2;

// final SharedPreferences sharedPreferences= SharedPreferences.getInstance() as SharedPreferences;
class B2BHome extends StatefulWidget {
  const B2BHome({Key? key}) : super(key: key);

  // String? name;
  // String? email;
  // String? mobile;
  // B2BHome({required this.name,required this.email,required this.mobile,});
  @override
  State<B2BHome> createState() => _B2BHomeState();
}
// final String? action = sharedPreferences.getString('name');

Future getValidation() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  obtainedId = sharedPreferences.getString('id');
  obtainedName = sharedPreferences.getString('username');
  obtainedEmail = sharedPreferences.getString('email');
  obtainedMobile = sharedPreferences.getString('mobile');
  // companyName=sharedPreferences.getString('mobile');
  bussinessAddress = sharedPreferences.getString('bussinessAddress');
  gstNumber = sharedPreferences.getString('gstNumber');
  udyogNumber = sharedPreferences.getString('udyogNumber');
  bussinessCategory = sharedPreferences.getString('bussinessCategory');
  country = sharedPreferences.getString('country');
  state = sharedPreferences.getString('state');
  district = sharedPreferences.getString('district');
  area = sharedPreferences.getString('area');
  pinCode = sharedPreferences.getString('pinCode');
  city = sharedPreferences.getString('city');
  partnerName = sharedPreferences.getString('partnerName');
  partnerNumber = sharedPreferences.getString('partnerNumber');
  googleAddress = sharedPreferences.getString('googleAddress');
  facebook = sharedPreferences.getString('facebook');
  insta = sharedPreferences.getString('insta');
  linkdin = sharedPreferences.getString('linkdin');

  print(obtainedId);
  print(obtainedName);
  print(obtainedEmail);
  print(obtainedMobile);
  print(insta);
  print(pinCode);
}

class _B2BHomeState extends State<B2BHome> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    sliderImages();
    _getAddressFromLatLng();
    getUserCurrentLocation();
    // TODO: implement initState
    getValidation();
    getSupplier();
    homeCategories();
    homeProducts();
    getProfile();
    getAdvertise();

  }

  bool isSwitched = false;
  var textValue = 'General';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Special';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'General';
      });
    }
  }

  String? _currentAddress;
  double lat = 0.0;
  double long = 0.0;
  Position? currentLocation;

  Future getUserCurrentLocation() async {

    var status = await Permission.location.request();
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    }else if(status.isGranted){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        if (mounted) {
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
        }
      });
      print("LOCATION===" +currentLocation.toString());
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _getAddressFromLatLng() async {
    await getUserCurrentLocation().then((_) async {
      try {
        print("Addressss function");
        List<Placemark> p = await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("current addresssss nowwwww${_currentAddress}");
        });
      } catch (e) {
        print('errorrrrrrr ${e}');
      }
    });
  }

  GetSupplierModel? getSupplierModel;
 getSupplier() async{
   final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   var sessionId= sharedPreferences.getString('id');
   var headers = {
     'Cookie': 'ci_session=bbef05fec3d04e54ce989d212a56be791511d2db'
   };
   var request = http.MultipartRequest('POST', Uri.parse('${ApiService.supplier}'));
   request.fields.addAll({
     'seller_id': '${sessionId}'
   });
    print("seller id in get supplier ${request.fields}");
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();
   if (response.statusCode == 200) {
     var finalResponse = await response.stream.bytesToString();
     final jsonResponse = GetSupplierModel.fromJson(json.decode(finalResponse));
     print("Get Supplierrrrr");
     setState(() {
       getSupplierModel = jsonResponse;
     });
   } else {
     print(response.reasonPhrase);
   }
 }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldState,
          drawer: Drawer(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    getValidation();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfile(
                                  name: '${namee}',
                                  email: '${emaill}',
                                  mobile: '${mobilee}',
                                  // companyName: '${companyName}',
                                  bussinessAddress: '${bussinessAddress2}',
                                  gstNumber: '${gstNumber2}',
                                  udyogNumber: '${udyogNumber2}',
                                  bussinessCategory: '${bussinessCategory2}',
                                  country: '${country2}',
                                  state: '${state2}',
                                  district: '${district2}',
                                  area: '${area2}',
                                  pinCode: '${pinCode2}',
                                  city: '${city2}',
                                  partnerName: '${partnerName2}',
                                  partnerNumber: '${partnerNumber2}',
                                  googleAddress: '${googleAddress2}',
                                  anyNumber: '${anyNumber2}', websiteLink: '${websiteLink2}',
                                  facebook: '${facebook2}',
                                  insta: '${insta2}',
                                  linkdin: '${linkdin2}',
                                ),
                        ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    color: colors.primary,
                    child: Row(
                      children: [
                        // Image.network("https://developmentalphawizz.com/B2B/seller/app/v1/api/uploads/seller/scaled_Screenshot_2023-07-22-07-19-02-27_40deb401b9ffe8e1df2f1cc5ba480b12.jpg"),
                        // CircleAvatar(
                        //   radius: 35, // Adjust the value as per your desired size
                        //   backgroundImage:NetworkImage("https://developmentalphawizz.com/B2B/seller/uploads/seller/scaled_Screenshot_2023-07-22-07-19-02-27_40deb401b9ffe8e1df2f1cc5ba480b12.jpg"),
                        //   // AssetImage("Images/bg.jpg"),
                        // ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${namee}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${emaill}",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${mobilee}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  height: 55,
                  color: Colors.grey[300],
                  child: Row(children: const [
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Home",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  height: 55,
                  color: Colors.grey[300],
                  child: Row(children: const [
                    Icon(Icons.privacy_tip_sharp),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Privacy",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  height: 55,
                  color: Colors.grey[300],
                  child: Row(children: const [
                    Icon(Icons.article_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Terms & Condition",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),

                SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('id');
                    sharedPreferences.remove('username');
                    sharedPreferences.remove('email');
                    sharedPreferences.remove('mobile');
                    sharedPreferences.remove('bussinessAddress');
                    sharedPreferences.remove('gstNumber');
                    sharedPreferences.remove('udyogNumber');
                    sharedPreferences.remove('bussinessCategory');
                    sharedPreferences.remove('country');
                    sharedPreferences.remove('state');
                    sharedPreferences.remove('district');
                    sharedPreferences.remove('area');
                    sharedPreferences.remove('pinCode');
                    sharedPreferences.remove('city');
                    sharedPreferences.remove('partnerName');
                    sharedPreferences.remove('partnerNumber');
                    sharedPreferences.remove('googleAddress');
                    sharedPreferences.remove('facebook');
                    sharedPreferences.remove('insta');
                    sharedPreferences.remove('linkdin');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    height: 55,
                    color: Colors.grey[300],
                    child: Row(children: [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),

                // MaterialButton(
                //     color:Colors.blue,
                //     child: Text("Sign Out"),
                //     onPressed: ()async{
                //       final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                //       sharedPreferences.remove('otp1');
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                //     }),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            child: InkWell(
                                onTap: () {
                                  _scaffoldState.currentState?.openDrawer();
                                },
                                child: Image.asset(
                                  "Images/drawer.png",
                                  height: 20,
                                  width: 20,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(
                              "Hii ${namee}",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$textValue',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Transform.scale(
                                  scale: 1 * 0.8,
                                  child: Switch(
                                    onChanged: toggleSwitch,
                                    value: isSwitched,
                                    activeColor: Color(0xffFD5E53),
                                    activeTrackColor: Color(0xffffffff),
                                    inactiveThumbColor: Color(0xffFD5E53),
                                    inactiveTrackColor: Color(0xffffffff),
                                  ),
                                )
                              ]),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10, left: 19),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                hintText: "${ _currentAddress != null
                                    ? _currentAddress!
                                    : "please wait.."}",
                                hintStyle: TextStyle(color: Colors.black54, fontSize: 10),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.location_pin, size: 20,),
                                prefixIconColor: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10, right: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                hintText: "Search",
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.black54),
                                prefixIcon: Icon(Icons.search, size: 20,),
                                prefixIconColor: Colors.black,
                                // suffixIcon: Icon(Icons.mic),
                                suffixIconColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    finalImages?.data == null || finalImages?.data == " " ? Center(child: CircularProgressIndicator(color: colors.primary,),):
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      child: CarouselSlider(
                        items: finalImages?.data
                            .map(
                              (item) => Image.network(
                                item.image,
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ).toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentIndex,
                        count: 5,
                        effect: const SlideEffect(
                          spacing: 5.6,
                          radius: 10.0,
                          dotWidth: 7.0,
                          dotHeight: 7.0,
                          dotColor: Color.fromRGBO(246, 137, 133, 0.5),
                          activeDotColor: Color(0xffFD5E53),
                        ),
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SupplierScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "Images/Buyer.png",
                                    height: MediaQuery.of(context).size.height / 9,
                                    width: MediaQuery.of(context).size.width / 5,
                                  ),
                                  const Text(
                                    "Supplier",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ClientScreen()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 7),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/img1.png",
                                      height:
                                          MediaQuery.of(context).size.height/9,
                                      width:
                                          MediaQuery.of(context).size.width/4.9,
                                    ),
                                    const Text(
                                      "Client",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 7),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "Images/activity.png",
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 5.7,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      right: 3,
                                    ),
                                    child: Text(
                                      "Our Activity",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: Image.asset(
                                    "Images/suggetion.png",
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 5.7,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: Text(
                                    "Your Suggestion",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllProduct(
                              // model: homeProductsModel?.data?[i]
                          )
                          ),
                          );
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/3.3,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeCategory?.data?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.all(4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: Column(
                                      children: [
                                        homeCategory?.data?[index].image == null
                                            ? Text("-", style: TextStyle(color: Colors.white),)
                                            : Image.network(
                                                "${homeCategory?.data?[index].image}",
                                                height: MediaQuery.of(context).size.height / 10,
                                                width: 100,
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${homeCategory?.data?[index].name}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                // homeCategories();
                                homeProducts();
                                print(homeCategory?.data?.length);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeFullCategory()));
                              },
                              child: Text("See All")),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: const Text(
                    "Products",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4.7,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProductsModel?.data?.length ?? 0,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            // product_image = listKitchen[ind]['image_path'];
                            // product_name = listKitchen[ind]['title'];
                            // product_price = listKitchen[ind]['price'];
                            // product_loc = listKitchen[ind]['address'];
                            print("indexxxxxx ${i}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KitchenDescription(
                                         model: homeProductsModel?.data?[i]
                                        ),
                                ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [

                                Container(
                                  height: 150,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Image.network(
                                      "${homeProductsModel?.data?[i].image}",fit: BoxFit.fill,),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${homeProductsModel?.data?[i].name}",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee_rounded,
                                          size: 15,
                                          weight: 800,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          "${homeProductsModel?.data?[i].variants?[0].price}",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                       Image.asset("Images/youtube.png", height: 15,),
                                        SizedBox(width: 10),
                                        Text("Watch Video", style: TextStyle(fontSize: 12),)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          size: 15,
                                          weight: 800,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          "${homeProductsModel?.data?[i].address}",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    ElevatedButton(
                                      onPressed: () {
                                        // product_image =
                                        //     listKitchen[index]['image_path'];
                                        // product_name =
                                        //     listKitchen[index]['title'];
                                        // product_price =
                                        //     listKitchen[index]['price'];
                                        // product_loc =
                                        //     listKitchen[index]['address'];
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             KitchenDescription(
                                        //               // image: product_image,
                                        //               // loc: product_loc,
                                        //               // price: product_price,
                                        //               // product_name:
                                        //               //     product_name,
                                        //             )));
                                      },
                                      child:
                                          Text("Contact Suppliere",
                                              style: TextStyle(
                                                fontSize: 11,
                                              )),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red[300]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                  //  width: 30,
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: EdgeInsets.only(left: 20),
                //   child: Text(
                //     "Furniture",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(5),
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height / 2.8,
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       scrollDirection: Axis.horizontal,
                //       physics: AlwaysScrollableScrollPhysics(),
                //       itemCount: listfurniture.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return GestureDetector(
                //           onTap: () {
                //             product_image = listfurniture[index]['image_path'];
                //             product_name = listfurniture[index]['title'];
                //             product_price = listfurniture[index]['price'];
                //             product_loc = listfurniture[index]['address'];
                //
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => FurnitureDescription(
                //                           image: product_image,
                //                           loc: product_loc,
                //                           price: product_price,
                //                           product_name: product_name,
                //                         )));
                //           },
                //           child: Card(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10)),
                //             child: Column(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     height: 120,
                //                     child: Image.asset(
                //                         listfurniture[index]['image_path']),
                //                   ),
                //                 ),
                //                 Align(
                //                   alignment: Alignment.topRight,
                //                   child: Column(
                //                     children: [
                //                       SizedBox(
                //                         height: 4,
                //                       ),
                //                       Text(
                //                         listfurniture[index]['title'],
                //                         textAlign: TextAlign.right,
                //                         style: TextStyle(
                //                             color: Colors.black,
                //                             fontWeight: FontWeight.w700,
                //                             fontSize: 13),
                //                       ),
                //                       SizedBox(
                //                         height: 6,
                //                       ),
                //                       Row(
                //                         children: [
                //                           Icon(
                //                             Icons.currency_rupee_rounded,
                //                             size: 15,
                //                             weight: 800,
                //                             color: Colors.black,
                //                           ),
                //                           Text(
                //                             "${listfurniture[index]['price']}",
                //                             textAlign: TextAlign.right,
                //                             style: TextStyle(fontSize: 11),
                //                           ),
                //                           SizedBox(
                //                             width: 6,
                //                           ),
                //                           Row(
                //                             children: [
                //                               Icon(
                //                                 Icons.call,
                //                                 size: 15,
                //                                 weight: 800,
                //                                 color: Colors.black,
                //                               ),
                //                               Text(
                //                                 listfurniture[index]['contact'],
                //                                 textAlign: TextAlign.right,
                //                                 style: TextStyle(fontSize: 11),
                //                               ),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                       SizedBox(
                //                         height: 6,
                //                       ),
                //                       Row(
                //                         children: [
                //                           Icon(
                //                             Icons.location_pin,
                //                             size: 15,
                //                             weight: 800,
                //                             color: Colors.black,
                //                           ),
                //                           Text(
                //                             listfurniture[index]['address'],
                //                             style: TextStyle(fontSize: 11),
                //                           ),
                //                         ],
                //                       ),
                //                       SizedBox(height: 8),
                //                       ElevatedButton(
                //                         onPressed: () {},
                //                         child: Text(
                //                           listfurniture[index]['button'],
                //                           style: TextStyle(fontSize: 11),
                //                         ),
                //                         style: ElevatedButton.styleFrom(
                //                             backgroundColor: Colors.red[300]),
                //                       ),
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         );
                //       }),
                // ),
                // SizedBox(
                //   height: 8,
                //   //  width: 30,
                // ),
                // Container(
                //     height: 100,
                //     margin: EdgeInsets.all(5),
                //     child: Image.asset("Images/Group 72235.png")),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: 20, left: 20, right: 20, bottom: 10),
                //   child: CarouselSlider(
                //     items: advertise?.data
                //         .map(
                //           (item) => Image.network(
                //         item.image,
                //         fit: BoxFit.fill,
                //         width: double.infinity,
                //       ),
                //     ).toList(),
                //     carouselController: carouselController,
                //     options: CarouselOptions(
                //       scrollPhysics: const BouncingScrollPhysics(),
                //       autoPlay: true,
                //       aspectRatio: 2,
                //       viewportFraction: 1,
                //       onPageChanged: (index, reason) {
                //         setState(() {
                //           currentIndex = index;
                //         });
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 8,
                  //  width: 30,
                ),
              ]),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print("${imagee}=========================================================");
          //     sliderImages();
          //     // homeCategories();
          //     // print("${result['data'][0]['image']}=====================================================");
          //     //           sliderImages();
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return SimpleDialog(
          //             contentPadding: EdgeInsets.zero,
          //             backgroundColor: Colors.transparent,
          //             children: <Widget>[
          //               Container(
          //                 height: 370,
          //                 width: 450,
          //                 child: Center(
          //                   child: Container(
          //                     alignment: Alignment.center,
          //                     child: GridView.builder(
          //                         physics: const NeverScrollableScrollPhysics(),
          //                         itemCount: 4,
          //                         gridDelegate:
          //                             const SliverGridDelegateWithFixedCrossAxisCount(
          //                           crossAxisCount: 2,
          //                           crossAxisSpacing: 2,
          //                           mainAxisSpacing: 2,
          //                           mainAxisExtent: 160,
          //                         ),
          //                         itemBuilder: (context, index) {
          //                           return Card(
          //                             margin: EdgeInsets.all(13),
          //                             shape: RoundedRectangleBorder(
          //                                 borderRadius:
          //                                     BorderRadius.circular(4)),
          //                             child: GestureDetector(
          //                               onTap: () {
          //                                 Navigator.pop(context);
          //                               },
          //                               child: Container(
          //                                 height: MediaQuery.of(context)
          //                                     .size
          //                                     .height,
          //                                 child: Column(
          //                                   children: [
          //                                     const SizedBox(
          //                                       height: 6,
          //                                     ),
          //                                     Image.asset(
          //                                       cardGrid[index]['image_path'],
          //                                       height: MediaQuery.of(context).size.height /8,
          //                                       width: MediaQuery.of(context).size.width / 3,
          //                                     ),
          //                                     const SizedBox(
          //                                       height: 8,
          //                                     ),
          //                                     Text(
          //                                       cardGrid[index]['title'],
          //                                       style: const TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 12),
          //                                     ),
          //                                     const SizedBox(
          //                                       height: 3,
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                           );
          //                         }),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           );
          //         });
          //   },
          //   backgroundColor: Colors.red[300],
          //   child: Icon(Icons.grid_view_outlined),
          // )
      ),
    );
  }

  getProfile()async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var sessionId= sharedPreferences.getString('id');

    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({
      'user_id': '${sessionId}'
    });

    print("sign up details para ${request.fields}==========================================================");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result2=await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
        // print("${store2}");
      });
    }
    if(profileStore2['error']==false){
      print("${profileStore2['data']['username']}=-=-=-=-=-=----=");
      imagee="${profileStore2['data']['broucher']}";
      namee="${profileStore2['data']['username']}";
      emaill="${profileStore2['data']['email']}";
      mobilee="${profileStore2['data']['mobile']}";
     // companyName2="${profileStore2['data']['mobile']}";
      bussinessAddress2="${profileStore2['seller_data']['company_address']}";
      gstNumber2="${profileStore2['seller_data']['tax_number']}";
      udyogNumber2="${profileStore2['seller_data']['udyog_num']}";
      bussinessCategory2="${profileStore2['seller_data']['udyog_num']}";
      country2="${profileStore2['data']['country']}";
      state2="${profileStore2['data']['state']}";
      district2="${profileStore2['data']['destrict']}";
      area2="${profileStore2['data']['area']}";
      pinCode2="${profileStore2['data']['pincode']}";
      city2="${profileStore2['data']['city']}";
      partnerName2="${profileStore2['seller_data']['partner']}";
      partnerNumber2="${profileStore2['seller_data']['partner_number']}";
      googleAddress2="${profileStore2['data']['address']}";
      // anyNumber2="${profileStore2['data']['address']}";
      websiteLink2="${profileStore2['seller_data']['web_link']}";
      facebook2="${profileStore2['seller_data']['facebook']}";
      insta2="${profileStore2['seller_data']['instagram']}";
      linkdin2="${profileStore2['seller_data']['linkedin']}";

    }
    else {
      print(response.reasonPhrase);
    }

  }


  GetHomeProductsModel? homeProductsModel;

  homeProducts() async {
    var headers = {
      'Cookie': 'ci_session=70e96d2327e44495fa936ae29e0b3378358ed10c'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getHomeProducts}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetHomeProductsModel.fromJson(jsonDecode(finalResponse));
      // for (int i = 0; i <= 22; i++) {
      //   print(homeProductsModel?.data![i].name);
      //   // print(homeCategory!.data![i].image);
      // }
      setState(() {
        homeProductsModel = jsonResponse;
        print('${homeProductsModel?.data?.length}______________');

      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetHomeCategoryModel? homeCategory;

  homeCategories() async {
    var headers = {
      'Cookie': 'ci_session=a0c4a8147cd6ca589ca5ea95dd55a72e8678d0d2'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ApiService.getHomeCategories}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          GetHomeCategoryModel.fromJson(json.decode(finalResponse));
      homeCategory = jsonResponse;

      print(homeCategory!.data!.first.name);
      setState(() {
        homeCategory = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}

 sliderImages() async {
  var headers = {
    'Cookie': 'ci_session=cfaf8a5af69a02ff6166d842c050ff4aa1d64eb1'
  };
  var request = http.Request(
      'POST', Uri.parse('${ApiService.getSliderImage}'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var store = await response.stream.bytesToString();
    finalImages = SliderImageModel.fromJson(json.decode(store));
  } else {
    print(response.reasonPhrase);
  }
}

getAdvertise()async{
  var headers = {
    'Cookie': 'ci_session=b2de8b9ed2c104bc965341dc47531c4496a0eb67'
  };
  var request = http.Request('POST', Uri.parse('${ApiService.advertise}'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }
}
