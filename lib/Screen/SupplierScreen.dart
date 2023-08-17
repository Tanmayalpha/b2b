import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/color.dart';
import 'package:b2b/utils/GetPreference.dart';
import 'package:b2b/widgets/categoryCard.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/suplier_Client_supplier_response.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Suppliers"),
        backgroundColor: colors.primary,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: colors.primary,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: supplierDataList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var item = supplierDataList[index];

                          return supplierOrClientCard(
                              context: context,
                              image: item.image,
                              sellerName: item.sellerName,
                              productName: item.name,
                              address: item.sellerAddress,
                              title: "Contact Supplier",onTap:  () {
                            contactToSupplier(item.id ?? '') ;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }

  List<ClientSupplierProductData> supplierDataList = [];

  bool isLoading = false;

  Future<void> getSupplier() async {
    setState(() {
      isLoading = true;
    });

    String? userId = await getString(key: 'id');

    var param = {"type": '1', "seller_id": userId ?? '438'};

    apiBaseHelper.postAPICall(getSupplierOrClientApi, param).then((getData) {
      bool error = getData['error'];
      String msg = getData['message'];

      if (!error) {
        var finalJson = GetSupplierOrClientResponse.fromJson(getData);

        supplierDataList = finalJson.product ?? [];

        setState(() {
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  Future<void> contactToSupplier(String itemId) async {
    String? mobile = await getString(key: 'mobile');

    String? userId = await getString(key: 'id');

    var param = {
      "user_id": userId,
      "product_id": itemId ?? '438',
      "mobile": mobile
    };

    apiBaseHelper
        .postAPICall(contactSupplierOrClientApi, param)
        .then((getData) {
      bool error = getData['error'];
      String msg = getData['message'];

      if (!error) {
        //var finalJson = GetSupplierOrClientResponse.fromJson(getData);
        Fluttertoast.showToast(msg: msg);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

}
