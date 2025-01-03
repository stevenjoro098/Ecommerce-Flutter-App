import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:entry/entry.dart';

import '../../controllers/FlashProductsController.dart';
import '../../views/mobileView/ProductDetailPage.dart';
import '../product.dart';

class FlashProductGrid extends StatelessWidget {

  final flashproductcontroller = Get.put(FlashProductsController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(flashproductcontroller.isLoading.value){
        return const Center(child: CircularProgressIndicator());
      }
      if (flashproductcontroller.products.isEmpty) {
        return const Center(child: Text('Data Unavailable'));
      }
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          //height: MediaQuery.of(context).size.height * 0.2,
        //width: MediaQuery.of(context).size.width,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            itemCount: flashproductcontroller.products.length,
            itemBuilder: (context, index) {
              final products = flashproductcontroller.products[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(
                      productName: products.name,
                      slug: products.slug,
                      price: products.price,
                      imageUrl: products.iconPath,
                      productDescription: products.description,
                    )),
                  );
                },
                child: Hero(
                  tag: '${products.name}-hero-image',
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Entry.scale(
                      duration: const Duration(seconds: 2),
                      child: ProductCard(
                        slug: products.slug,
                        imageUrl: products.iconPath,
                        productName: products.name, // Display actual product name
                        productPrice: products.price, // Display actual product price
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      );
    });
  }
}

// Custom ScrollBehavior for Linux scrolling compatibility
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Removes any platform-specific visual effects
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // Ensures smooth scrolling
  }
}
