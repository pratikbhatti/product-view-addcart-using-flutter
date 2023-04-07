


import 'package:get/get.dart';
class HomeController extends GetxController
{
  RxInt i =0.obs;

  void changeIndex(int index)
  {
    i.value = index;
  }
}