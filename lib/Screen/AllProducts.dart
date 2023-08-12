import 'package:flutter/material.dart';

import '../color.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  State<AllProduct> createState() => _AllProductState();
}

String? product_image;
String? product_name;
String? product_price;
String? product_loc;


List<Map<String, dynamic>> listfurniture = [
  {
    'image_path': 'Images/PlayFurniture.png',
    'title': 'Play Furniture',
    'price': '99/piece',
    'contact': '123-456-7890',
    'address': 'Vijay Nagar,indore ',
    'button': 'Contact Supplier'
  },
  {
    'image_path': 'Images/automobile.png',
    'title': 'Automobile Furniture',
    'price': '99/piece',
    'contact': '123-456-7890',
    'address': 'Sindhi Colony ,indore ',
    'button': 'Contact Supplier'
  },
  {
    'image_path': 'Images/modern-office-space-interior.png',
    'title': 'Office Furniture',
    'price': '99/piece',
    'contact': '123-456-7890',
    'address': 'Sindhi Colony,indore ',
    'button': 'Contact Supplier'
  },
];
class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Product"),
        backgroundColor: colors.primary,
        elevation: 0,
      ),
      body:Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height / 2.8,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: PageScrollPhysics(),
            itemCount: listfurniture.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  product_image = listfurniture[index]['image_path'];
                  product_name = listfurniture[index]['title'];
                  product_price = listfurniture[index]['price'];
                  product_loc = listfurniture[index]['address'];
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => FurnitureDescription(
                  //           image: product_image,
                  //           loc: product_loc,
                  //           price: product_price,
                  //           product_name: product_name,
                  //         )));
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: MediaQuery.of(context).size.height*0.20,
                          child: Image.asset(
                              listfurniture[index]['image_path']),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 250),
                              child: Text(
                                listfurniture[index]['title'],
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15,),
                                Icon(
                                  Icons.currency_rupee_rounded,
                                  size: 15,
                                  color: Colors.black,
                                ),
                                Text(
                                  "${listfurniture[index]['price']}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 11),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Row(
                                  children: [

                                    Icon(
                                      Icons.call,
                                      size: 15,
                                      weight: 800,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      listfurniture[index]['contact'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15,),

                                Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  weight: 800,
                                  color: Colors.black,
                                ),
                                Text(
                                  listfurniture[index]['address'],
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.95,
                              child: ElevatedButton(
                                onPressed: () {},

                                child: Text(
                                  listfurniture[index]['button'],
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[300]),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}