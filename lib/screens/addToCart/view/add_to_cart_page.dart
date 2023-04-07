import 'package:demo51/screens/viewPage/controller/view_product_controller.dart';
import 'package:demo51/utility/helpers/Db_Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({Key? key}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  ViewProductController viewProductController = Get.put(ViewProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewProductController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add to Cart"),
          centerTitle: true,
        ),
        body:
            Obx(()=>

        ListView.builder(itemCount:viewProductController.data.length ,itemBuilder: (context, index) {
          return Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width/7,
                child:Image.network("${viewProductController.data[index]['image']}") ,
                ),


                title: Row(
                  children: [
                    Text("Name:- "),
                    SizedBox(width: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width/4,
                        child: Text(
                            overflow: TextOverflow.ellipsis,
                            "${viewProductController.data[index]['name']}",maxLines: 2,)),
                  ],
                ),
                subtitle:  Row(
                  children: [
                    Text("Price:- "),
                    SizedBox(width: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width/5,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "${viewProductController.data[index]['price']}",maxLines: 1,)),
                  ],
                ),
                trailing: IconButton(onPressed: (){
                    DbHelper.dbHelper.deleteData(id: viewProductController.data[index]['id']);
                    viewProductController.getData();
                    Get.snackbar("Product Delete", "Successfully",backgroundColor: Colors.green);
                }, icon: Icon(Icons.delete,color: Colors.red,)),

                // Image.network("${viewProductController.data[index]['image']}"),

              ),
            ),
          );

        },),),
        // body: ,
      ),
    );
  }
}
