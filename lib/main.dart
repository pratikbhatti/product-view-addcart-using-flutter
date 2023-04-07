import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/homePage/view/home_page.dart';

void main()
{
  runApp(GetMaterialApp(
    theme: ThemeData(
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ),);
}
