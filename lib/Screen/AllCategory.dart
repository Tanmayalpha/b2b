import 'dart:convert';

// import 'package:anoop/Model/GetHomeCategoryModel.dart';
import 'package:b2b/widgets/categoryCard.dart';
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
          title: const Text("All Category"), backgroundColor: colors.primary),
      body: homeCategory?.data == null ? const Center(child: CircularProgressIndicator(color: colors.primary,),) : SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: homeCategory?.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return categoryCard(context,homeCategory?.data?[index].image ?? '', homeCategory?.data?[index].name ?? '' );
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
