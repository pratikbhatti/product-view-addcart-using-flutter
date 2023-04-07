import 'package:demo51/screens/addToCart/view/add_to_cart_page.dart';
import 'package:demo51/screens/homePage/controller/homeController.dart';
import 'package:demo51/screens/homePage/modal/home_modal.dart';
import 'package:demo51/screens/viewPage/controller/view_product_controller.dart';
import 'package:demo51/utility/helpers/Db_Helper.dart';
import 'package:demo51/utility/helpers/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  HomeController homeController = Get.put(HomeController());
  ViewProductController viewProductController = Get.put(ViewProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>?>(
            future: ApiCall.apiCall.productsApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<dynamic>? l1 = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 2,

                          child: Image.network(
                              "${l1![homeController.i.value].image}",
                              fit: BoxFit.cover),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Product Name :- ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "${l1![homeController.i.value].title}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${l1![homeController.i.value].description}"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rating :- ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${l1![homeController.i.value].rating.rate}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price :- ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${l1![homeController.i.value].price}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add To Card",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              DbHelper.dbHelper.insertData(
                                  image: "${l1![homeController.i.value].image}",
                                  name: "${l1![homeController.i.value].title}",
                                  desc:
                                      "${l1![homeController.i.value].description}",price: "${l1![homeController.i.value].price}");
                              viewProductController.getData();
                              Get.to(AddToCartPage());
                              Get.snackbar("Product Added", "Successfully",backgroundColor: Colors.green);
                            },
                            icon: Icon(
                              Icons.shopping_bag,
                              color: Colors.green,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );

                // List<dynamic>? l1 = snapshot.data;
                // return

                //   Padding(
                //   padding: const EdgeInsets.all(8.0),
                //
                //   child: GridView.builder(
                //     itemCount: 1,
                //
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //
                //         crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                //     itemBuilder:(context, index) {
                //       return InkWell(
                //         onTap: (){
                //           homeController.changeIndex(index);
                //           Get.to(ViewProductPage());
                //         },
                //         child: Card(
                //             elevation: 12,
                //             child: Column(
                //               children: [
                //                 Container(
                //                     height: MediaQuery.of(context).size.height/6,
                //                     width: MediaQuery.of(context).size.width/4,
                //                     child: Image.network("${l1![homeController.i.value].image}")),
                //                 SizedBox(height: 5,),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 5),
                //                   child: Container(
                //                       width: MediaQuery.of(context).size.width,
                //                       child: Text(
                //                         overflow: TextOverflow.ellipsis,
                //                         "${l1![homeController.i.value].title}",maxLines: 1,)),
                //                 ),
                //               ],
                //             )),
                //       );
                //     },
                //   ),
                //
                // );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
