import 'package:demo51/utility/helpers/Db_Helper.dart';
import 'package:get/get.dart';

class ViewProductController extends GetxController
{
  RxList<Map> data = <Map>[].obs;
  void getData() async {
   data.value = await DbHelper.dbHelper.readData();
  }
}