import 'dart:convert';

// import 'package:anoop/Model/GetHomeCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetHomeCategoryModel.dart';
import '../color.dart';

class HomeFullCategory extends StatefulWidget {
  const HomeFullCategory({Key? key}) : super(key: key);

  @override
  State<HomeFullCategory> createState() => _HomeFullCategoryState();
}

class _HomeFullCategoryState extends State<HomeFullCategory> {
  @override
  void initState() {
    homeCategories();
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: Text("All Category"), backgroundColor: colors.primary),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: homeCategory?.data?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return Card(margin: EdgeInsets.all(4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    child: Column(
                      children: [homeCategory?.data?[index].image==null?CircularProgressIndicator():
                        Image.network("${homeCategory?.data?[index].image}",
                          height:MediaQuery.of(context).size.height /13,
                          width: 100,
                        ),
                        SizedBox(height:5 ,),
                        Text("${homeCategory?.data?[index].name}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),),
                      ],
                    ),
                  ),
                );
              }),

        ),
      ),
    );
  }
  GetHomeCategoryModel? homeCategory;

  homeCategories()async{
    var headers = {
      'Cookie': 'ci_session=a0c4a8147cd6ca589ca5ea95dd55a72e8678d0d2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/B2B/seller/app/v1/api/get_home_categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetHomeCategoryModel.fromJson(json.decode(finalResponse));
      homeCategory = jsonResponse;

      print(homeCategory!.data!.first.name);
      // for(int i=0;i<=22;i++)
      //   {
      //     print(homeCategory!.data![i].image);
      //
      //   }

      setState(() {
        homeCategory = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
