import 'package:b2b/color.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';


class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Suppliers"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(

              alignment: Alignment.center,
              child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // height: MediaQuery.of(context).size.height/1.6,
                      // width: MediaQuery.of(context).size.width/1.1,
                      margin: EdgeInsets.all(20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height:MediaQuery.of(context).size.height/4.2,
                                width:MediaQuery.of(context).size.width,
                                child: Image.asset("Images/Agriculture.png",
                                  fit: BoxFit.contain,)
                            ),
                            Container(
                              margin:EdgeInsets.only(left: 24,top: 25),
                              child: Text("Mangossess",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Container(
                              margin:EdgeInsets.only(left: 24,top: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.person_rounded),
                                  SizedBox(width: 10,),
                                  Text("Ganesh Ginning"),
                                ],
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(left: 24,top: 5),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.red,
                                    child:Icon(Icons.location_pin,
                                      color: Colors.white,
                                    ) ,
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Gondal, Gujarat,360311,India"),
                                ],
                              ),
                            ),

                            Container(
                              margin:EdgeInsets.only(left: 20,top: 5,right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child:Icon(Icons.smart_display_rounded,
                                          color: Colors.red,
                                        ) ,
                                      ),

                                      Text("Watch Video")

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child:Icon(Icons.image,
                                            color: colors.primary,)
                                      ) ,

                                      Text("Broucher Image")

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.height/90 ,),
                            Container(
                              margin:EdgeInsets.only(left: 20,right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.indigoAccent,
                                    child:Icon(Icons.call,
                                      color: Colors.white,
                                    ) ,
                                  ),


                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        color: Colors.deepPurple
                                    ),
                                    child:Padding(
                                      padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                                      child: Icon(Icons.message,
                                        color: Colors.white,
                                      ) ,
                                    )  ,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        color:Colors.green
                                    ),
                                    child:Padding(
                                      padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                                      child: Icon(Icons.mail_outline,
                                        color: Colors.white,
                                      ) ,
                                    )  ,
                                  ),


                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.red,
                                    child:Icon(Icons.location_pin,
                                      color: Colors.white,
                                    ) ,
                                  ),
                                  Container(
                                      height:MediaQuery.of(context).size.height/20,
                                      width: MediaQuery.of(context).size.width/3,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          border:Border.all(
                                              width: 2,
                                              color: Colors.grey
                                          ),
                                          color: Colors.indigo
                                      ),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.orangeAccent,
                                            child:Icon(Icons.description,
                                              color: Colors.white,
                                            ) ,
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.lightBlue,
                                            child:Icon(Icons.check_circle_outline,
                                              color: Colors.white,
                                            ) ,
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.red,
                                            child:Icon(Icons.verified_user,
                                              color: Colors.white,
                                            ) ,
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.height/50 ,),

                            InkWell(
                              onTap: () {
                              },
                              child: Center(
                                child: Container(
                                  // margin:EdgeInsets.only(left: 24,top: 10),
                                  width: 220,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                        "Contact Supplier",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height:MediaQuery.of(context).size.height/40 ,),
                          ],
                        ),
                      ),
                    );
                  }),




            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
