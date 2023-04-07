import 'package:demo51/screens/addToCart/view/add_to_cart_page.dart';
import 'package:demo51/screens/homePage/controller/homeController.dart';
import 'package:demo51/screens/homePage/modal/home_modal.dart';
import 'package:demo51/screens/viewPage/controller/view_product_controller.dart';
import 'package:demo51/screens/viewPage/view/view_product_page.dart';
import 'package:demo51/utility/helpers/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  ViewProductController viewProductController =
      Get.put(ViewProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Products Page"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AddToCartPage());
                  viewProductController.getData();
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: Colors.green,
                )),
          ],
        ),
        body: FutureBuilder<List<dynamic>?>(
          future: ApiCall.apiCall.productsApi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<dynamic>? l1 = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: l1!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        homeController.changeIndex(index);
                        Get.to(ViewProductPage());
                      },
                      child: Card(
                          elevation: 12,
                          child: Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),),
                                    
                                      child:
                                          Image.network("${l1[index].image}"))),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${l1[index].title}",
                                      maxLines: 1,
                                    )),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
