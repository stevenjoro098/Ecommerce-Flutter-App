import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/responsiveUI/layoutBuilder.dart';
import 'app/controllers/CartController.dart';
import 'app/controllers/DeliveryInfoController.dart';
import 'app/controllers/ProductsController.dart';
import 'app/controllers/RegisterLoginController.dart';
import 'app/controllers/categoryController.dart';
import 'app/controllers/OrdersController.dart';
import 'app/views/mobileView/Home/Home.dart';
import 'app/views/mobileView/IntroductionPageView.dart';
import 'app/views/mobileView/RegistrationPage.dart';


void main() {
  Get.put(CartController());
  Get.put(ProductController());
  Get.put(CategoryController());
  Get.put(DeliveryInfoController());
  Get.put(OrderController());
  Get.put(AuthenticationController());

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
      home: SplashScreen()//const ResponsiveLayout(),
    );
  }
}
class SplashScreen extends StatelessWidget {
  Future<Widget> _getInitialPage() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isFirstTime) {
      return IntroPage();
    } else if (isLoggedIn) {
      return HomePage();
    } else {
      return RegistrationPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data ?? CircularProgressIndicator();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}