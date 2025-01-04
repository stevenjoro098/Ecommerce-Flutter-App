import 'dart:math';

import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/ProductsController.dart';
import 'mobileView/ProductDetailPage.dart';

class ProductsListPageView extends StatefulWidget {
  final String categoryName;
  ProductsListPageView({super.key, required this.categoryName});


  @override
  State<ProductsListPageView> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsListPageView> {
  final ProductController productController = Get.find();
  final CartController cartController = Get.find();
  final random = Random();
  @override
  void initState(){
    super.initState();
    productController.fetchProducts(widget.categoryName);
  }

  @override
  void dispose(){
    super.dispose();
    productController.products.clear();
    productController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName.toUpperCase()),
        elevation: 3,
      ),
      body:Obx((){
        if(productController.isLoading.value){
          return const Center(child: CircularProgressIndicator());
        }
        else if (productController.products.isEmpty) {
          return const Center(child: Text('Data Unavailable'));
        }

        return Column(
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productController.products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 20.0,
                      childAspectRatio: 1, // Adjust this for the height/width ratio
                    ),
                    itemBuilder: (context, index){
                      var product = productController.products[index];
                      return Entry.all(
                        delay: Duration(milliseconds: random.nextInt(300)),
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures the child widgets take up full width
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0), // Adds rounded corners
                                  child: Image.network(
                                    product.iconPath,
                                    fit: BoxFit.cover, // Makes the image fit within the card
                                    width: double.infinity, // Ensures the image takes up full width
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Ksh. ${product.price.toString()}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 1.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed:(){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => ProductDetailScreen(
                                                  productName: product.name,
                                                  slug: product.slug,
                                                  price: product.price,
                                                  imageUrl: product.iconPath,
                                                  productDescription: product.description,
                                                )),
                                              );
                                            },
                                            icon:const Icon(Icons.remove_red_eye_outlined)
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Add to cart logic here
                                            cartController.addItem(
                                                product.slug,
                                                product.iconPath,
                                                product.name,
                                                product.price
                                            );
                                          },
                                          icon: const Icon(Icons.add_shopping_cart),
                                        ),
                                      ],
                                    )
                                    // Adds spacing

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    }),
              ),
            )
          ],
        );
      })
    );
  }
}
