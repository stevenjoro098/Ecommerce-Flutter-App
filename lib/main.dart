import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/responsiveUI/layoutBuilder.dart';
import 'app/controllers/CartController.dart';
import 'app/controllers/DeliveryInfoController.dart';
import 'app/controllers/ProductsController.dart';
import 'app/controllers/categoryController.dart';
import 'app/controllers/OrdersController.dart';


void main() {
  Get.put(CartController());
  Get.put(ProductController());
  Get.put(CategoryController());
  Get.put(DeliveryInfoController());
  Get.put(OrderController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ECommerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        primaryColor: Colors.lightGreenAccent,
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      home: const ResponsiveLayout(
        // change the layout based on screen size
      ),
    );
  }
}