import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
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
                child: ProductCard(
                  imageUrl: products.iconPath,
                  productName: products.name, // Display actual product name
                  productPrice: products.price, // Display actual product price
                ),
              ),
            );
          },
        )
      );
    });
  }
}
