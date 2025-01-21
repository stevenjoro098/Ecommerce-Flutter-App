import 'dart:math';

import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../controllers/ProductsController.dart';
import 'ProductDetailPage.dart';

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
  Color textColor = Colors.red;
  @override
  void initState(){
    super.initState();
    productController.fetchProducts(widget.categoryName);
  }
  Future<Color> _updateTextColor(String url) async{
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(url));
    return textColor = paletteGenerator.dominantColor?.bodyTextColor ?? Colors.red;
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

        return SingleChildScrollView(
          child: Column(
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
                        //Color textColor = _updateTextColor(product.iconPath) as Color;
                        return Entry.all(
                          delay: Duration(milliseconds: random.nextInt(300)),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                //height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(product.iconPath),
                                    fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(16.0)
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title:Text(
                                            product.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                //color: textColor
                                            ),
                                          ),
                                          subtitle:Text(
                                            'Ksh. ${product.price.toString()}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          // trailing:IconButton(
                                          //     onPressed: () {
                                          //       // Add to cart logic here
                                          //       cartController.addItem(
                                          //           product.slug,
                                          //           product.iconPath,
                                          //           product.name,
                                          //           product.price
                                          //       );
                                          //     },
                                          //     icon: const Icon(Icons.add_shopping_cart),
                                          //   ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton.filled(
                                                onPressed: (){
                                                  // Add to cart logic here
                                                  cartController.addItem(
                                                      product.slug,
                                                      product.iconPath,
                                                      product.name,
                                                      product.price
                                                  );
                                                },
                                                icon: Icon(Icons.add_shopping_cart)
                                            ),
                                            IconButton.filled(
                                                onPressed: (){
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
                                                icon: Icon(Icons.remove_red_eye_outlined)
                                            )

                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                          // child: Card(
                          //   elevation: 2,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures the child widgets take up full width
                          //     children: [
                          //       Expanded(
                          //         child: ClipRRect(
                          //           borderRadius: BorderRadius.circular(10.0), // Adds rounded corners
                          //           child: Image.network(
                          //             product.iconPath,
                          //             fit: BoxFit.cover, // Makes the image fit within the card
                          //             width: double.infinity, // Ensures the image takes up full width
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               product.name,
                          //               style: const TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             Text(
                          //               'Ksh. ${product.price.toString()}',
                          //               style: const TextStyle(
                          //                 color: Colors.green,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             const SizedBox(height: 1.0),
                          //             Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 IconButton(
                          //                     onPressed:(){
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(builder: (context) => ProductDetailScreen(
                          //                           productName: product.name,
                          //                           slug: product.slug,
                          //                           price: product.price,
                          //                           imageUrl: product.iconPath,
                          //                           productDescription: product.description,
                          //                         )),
                          //                       );
                          //                     },
                          //                     icon:const Icon(Icons.remove_red_eye_outlined)
                          //                 ),
                          //                 IconButton(
                          //                   onPressed: () {
                          //
                          //                   },
                          //                   icon: const Icon(Icons.add_shopping_cart),
                          //                 ),
                          //               ],
                          //             )
                          //             // Adds spacing
                          //
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        );
          
                      }),
                ),
              )
            ],
          ),
        );
      })
    );
  }
}
