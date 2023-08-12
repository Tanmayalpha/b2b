import 'dart:convert';
import 'dart:io';
import 'package:b2b/Constant/Constants.dart';
import 'package:b2b/Model/businessCategoruModel.dart';
import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/ProductForm.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:b2b/widgets/multi_select_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetCountriesModel.dart';
import '../Model/GetStateModel.dart';

// import 'Model/businessCategoruModel.dart';
import '../color.dart';

var jsonData;
var store;

TextEditingController companycontroller = TextEditingController();
TextEditingController businessAddressController = TextEditingController();
TextEditingController gstController = TextEditingController();
TextEditingController udyogController = TextEditingController();
TextEditingController businessCategoryController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController districtController = TextEditingController();
TextEditingController areaController = TextEditingController();
TextEditingController pincodeController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController partnerNameController = TextEditingController();
TextEditingController partnerNumberController = TextEditingController();
TextEditingController googleAddressController = TextEditingController();
TextEditingController anyController = TextEditingController();
TextEditingController websiteController = TextEditingController();
TextEditingController facebookController = TextEditingController();
TextEditingController instaController = TextEditingController();
TextEditingController linkdinController = TextEditingController();
TextEditingController imageController = TextEditingController();

class DetailPage extends StatefulWidget {
  // const DetailPage({super.key});
  String? userName;
  String? userMobile;
  String? userEmail;

  DetailPage(
      {required this.userName, required this.userMobile, required this.userEmail});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();

  // List items = ['Madhya pradesh', 'Uttar Pradesh', 'Bihar', 'Rajasthan', 'Tamil Nadu',];
  // List items1 = ['Indore', 'Ujjain', 'Gwalior', 'Nashik', 'Bhopal',];
  // List items2 = ['Bhawarkua', 'Malwa Mill', 'Railway Statition', 'VijayNagar', 'L.I.G',];

  String? categoryValue;

  StateData? stateValue;
  CityData? countryValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      return businessCategory();
    });
    Future.delayed(Duration(milliseconds: 400), () {
      return getCountries();
    });
  }

  BusinessCategoruModel? businesscatorymodel;

  Future<void> businessCategory() async {

    apiBaseHelper.getAPICall(getBusinessCategory).then((getData) {

      bool error = getData ['error'];

      if(!error){
        businesscatorymodel = BusinessCategoruModel.fromJson(getData);
      }else {

      }

    });

  }

  String? country_id;
  GetCountriesModel? getcountriesmodel;
  GetStateModel? getStateModel;

  File? file;

  Future<void> getCountries() async {
    apiBaseHelper.getAPICall(getCountry).then((getData) {
      bool error = getData['error'];
      if (!error) {
        setState(() {
          getcountriesmodel = GetCountriesModel.fromJson(getData);
        });
      }
    });
  }

  Future<void> getState() async {
    var parameter = {"country_id": countryValue?.id};

    apiBaseHelper.postAPICall(getSate, parameter).then((getData) {
      bool error = getData['error'];
      if (!error) {
        setState(() {
          getStateModel = GetStateModel.fromJson(getData);
        });
      }
    });
  }

  // final ImagePicker _imagePicker = ImagePicker() ;

  Future<void> chooseImage(type) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path ?? '');
      imageController.text = result.files.single.name ?? '' ;

    } else {
      // User canceled the picker
    }

    /* if (type == "Camera") {
      image = await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {

        imageController.text = image?.name ?? '' ;

       // base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('Images/bg-4.png'),
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.9)),
                          ],
                          border:
                          Border.all(color: Theme.of(context).focusColor),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  'Business Details',
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 30, bottom: 2, right: 30),
                                  child: select()),
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 30, bottom: 2, right: 30),
                                  child: TextFormField(
                                    controller: companycontroller,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Company\\Business\\Shop Name',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: Icon(Icons.person),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !RegExp(r'^[a-z || A-Z]')
                                              .hasMatch(value)) {
                                        return 'This value is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // email
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: businessAddressController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Business Address',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_on),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z || 0-9]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: gstController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'GST Number(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.list_alt_outlined),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[0-9]').hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: udyogController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Udyog Number(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[0-9]').hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              /*Container(
                                width: 248,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String?>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 13.5),
                                      prefixIcon: Icon(Icons.apps_rounded),
                                    ),
                                    value: categoryValue,
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Text(
                                      "Bussiness Category",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    items:
                                        businesscatorymodel?.data?.map((items) {
                                      return DropdownMenuItem(
                                        value: items.name.toString(),
                                        child: Container(
                                            child: Text(items.name.toString())),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        categoryValue = newValue;
                                        print(
                                            "selected category $categoryValue");
                                      });
                                    },
                                  ),
                                ),
                              ),*/

                              Container(
                                width: 248,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<CityData>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 13.5),
                                      prefixIcon: Icon(Icons.business_rounded),
                                    ),
                                    value: countryValue,
                                    // underline: Container(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    hint: Text(
                                      "Country",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    items: getcountriesmodel?.data?.map((item) {
                                      return DropdownMenuItem<CityData>(
                                        value: item,
                                        child: Text(item.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (CityData? newValue) {
                                      setState(() {
                                        countryValue = newValue;
                                        stateValue = null;
                                      });
                                      getState();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: 248,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<StateData>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 13.5),
                                      prefixIcon: Icon(Icons.holiday_village),
                                    ),
                                    value: stateValue,
                                    // underline: Container(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    hint: Text(
                                      "State",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    items: getStateModel?.data?.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (StateData? newValue) {
                                      setState(() {
                                        stateValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: districtController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'District',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_pin),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z ]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: areaController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Area',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_pin),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z || 0-9]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: pincodeController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26)),
                                    hintText: 'Pin code',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[0-9]{6}')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: cityController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    hintText: 'City',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon:
                                    Icon(Icons.location_off_rounded),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: partnerNameController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Partner Name',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: partnerNumberController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Partner Number',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.call),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[0-9]').hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: googleAddressController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Google Address',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_on),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: anyController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Any Other Number',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.call),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[0-9]').hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: websiteController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Enter Website Link',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: Icon(Icons.link),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                      labelText:
                                      'Website Page Link (Optional)'),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: facebookController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Paste here facebook page link',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: Icon(Icons.facebook,),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                      labelText:
                                      'Facebook Link (Optional)'),
                                  /*validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },*/
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: instaController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Paste here Instagram page link',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: ImageIcon(AssetImage('Images/instagram.png',)),
                                      prefixIconConstraints:
                                      BoxConstraints(
                                        minWidth: 50, maxHeight: 20,),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                      labelText:
                                      'Instagram page link'),

                                  /*validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },*/
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: linkdinController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Paste here linkedin page link',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: ImageIcon(AssetImage('Images/in2.png',)),
                                      prefixIconConstraints:
                                      BoxConstraints(
                                        minWidth: 50, maxHeight: 20,),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                      labelText:
                                      'linkedin page link'),

                                  /*validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },*/
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: imageController,
                                  cursorColor: Colors.black,
                                  readOnly: true,
                                  onTap: (){
                                    chooseImage('');
                                  },
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Choose File',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: Icon(Icons.file_copy_outlined),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                      labelText:
                                      'Business Brochure'),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'^[a-z || A-Z]')
                                            .hasMatch(value)) {
                                      return 'This value is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 45),
                              btn(title: 'Complete',onTap: () {
                                if (_formKey.currentState!.validate()) {


                                  userRegister(false);

                                }
                              }),
                              const SizedBox(height: 15),
                              isLoading ? const Center(child: CircularProgressIndicator(color: colors.primary,),) :  btn( title: 'Product Detail Page',onTap: () {

                                if (_formKey.currentState!.validate()) {

                                  userRegister(true);
                                }
                              }),
                              const SizedBox(height: 50),
                            ],
                          ),
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
    );
  }

  // bussinessData() async {
  //   var headers = {
  //     'Cookie': 'ci_session=29ece16846babbf1b660f09a41dbf23e21a61794'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/B2B/seller/app/v1/api/business_cat'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var result=await response.stream.bytesToString();
  //     setState(() {
  //       store=jsonDecode(result);
  //       print(result.length);
  //       //  print(jsonDecode(result));
  //       //   final data = result['data'] as List<dynamic>;
  //     });
  //     if(store['error']==false)
  //     {
  //       // print(jsonDecode(result));
  //       for(int i=0;i<=result.length;i++)
  //       {
  //         //  print(store['data']['name']);
  //         print("right==================");
  //       }}
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //     print("wrongg===================");
  //   }
  // }
  bool isLoading = false ;

  Future<void> userRegister(bool isFrom ) async {
    setState(() {
      isLoading = true ;
    });

    var headers = {
      'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3'
    };
    var request = http.MultipartRequest('POST', getUserRegister);
    request.fields.addAll({
      'name': companycontroller.text,
      'mobile': widget.userMobile ?? '',
      'email': widget.userEmail ?? '',
      'address': 'Address',
      'user_name': widget.userName ?? '',
      'user_mobile': widget.userMobile ?? '',
      'store_name': 'Harish Store',
      'tax_name': 'GST',
      'tax_number': gstController.text,
      'company_address': businessAddressController.text,
      'udyog_num': udyogController.text,
      'other_number': anyController.text,
      'partner': partnerNameController.text,
      'partner_number': partnerNumberController.text,
      'facebook': facebookController.text,
      'instagram': instaController.text,
      'linkedin': linkdinController.text,
      'type_of_seller': results.join(','),
      'state': stateValue?.id ?? '',
      'destrict': districtController.text,
      'city': cityController.text,
      'area': areaController.text,
      'pincode': pincodeController.text,
      'country': countryValue?.id ?? '',
      'google_address': googleAddressController.text,
      'lat': '',
      'lang': ''
    });

    request.files.add(await http.MultipartFile.fromPath('broucher', file?.path ?? ''));

    print("sign up details para ${request.fields}");



    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      store = jsonDecode(result);
      print(store['message']);
      if (store['error'] == false) {

       var userName = store['user_data']['username'];
       var email = store['user_data']['email'];
        var mobile= store['user_data']['mobile'];
        var sessionId =store['user_id'];
         userId = store['data']['id'];

        if(isFrom){
          await Future.delayed(const Duration(seconds: 2));
          if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductFormScreen()));
        }else {
          await Future.delayed(const Duration(seconds: 2));

          if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BHome()));
        }
        setState(() {
          isLoading = false ;
        });

        Fluttertoast.showToast(
          msg: store['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: colors.white,
        );
      } else {
        Fluttertoast.showToast(msg: store['message']);
        setState(() {
          isLoading = false ;
        });
        print(response.reasonPhrase);
      }
    }
  }

  List<String> results = [];

  Widget select() {
    return InkWell(
      onTap: () {
        setState(() {
          _showMultiSelect();
        });
      },
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: colors.white,
              border: Border(
                  bottom: BorderSide(color: colors.black.withOpacity(0.5)))),
          child: results.isEmpty
              ? const Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Text(
              'Select Business Category',
              style: TextStyle(
                fontSize: 16,
                color: colors.black,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: results.map((e) {
                return Padding(
                  padding:
                  const EdgeInsets.only(top: 10, left: 1, right: 1),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: colors.primary),
                      child: Center(
                          child: Text(
                            "${e}",
                            style: TextStyle(color: colors.white),
                          ))),
                );
              }).toList(),
            ),
          )),
    );
  }

  void _showMultiSelect() async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiSelect(sellerList: businesscatorymodel?.data);
        });
      },
    );
    setState(() {});
  }
}
