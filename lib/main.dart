import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/bindings/home_binding.dart';

import 'app/ui/pages/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPlayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: HomeBinding(),
      home: HomePage(),
    );
  }
}
