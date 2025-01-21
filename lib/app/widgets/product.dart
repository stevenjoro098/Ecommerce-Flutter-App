import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math';

import '../views/mobileView/ProductDetailPage.dart';


class ProductCard extends StatefulWidget {
  final String slug;
  final String imageUrl;
  final String productName;
  final double productPrice;

  ProductCard({
    super.key,
    required this.slug,
    required this.imageUrl,
    required this.productName,
    required this.productPrice
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  final random = Random();
  Color textColor = Colors.red;

  Future<void> _updateTextColor() async{
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(widget.imageUrl));
    setState(() {
      textColor = paletteGenerator.dominantColor?.bodyTextColor ?? Colors.red;
    });

  }
  @override
  void initState(){
    super.initState();
    _updateTextColor();
  }
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Entry.all(
      delay: Duration(milliseconds: random.nextInt(300)),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            //height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
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
                        widget.productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white60
                        ),
                      ),
                      subtitle:Text(
                        'Ksh. ${widget.productPrice.toString()}',
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
                                  widget.slug,
                                  widget.imageUrl,
                                  widget.productName,
                                  widget.productPrice
                              );
                            },
                            icon: Icon(Icons.add_shopping_cart)
                        ),
                        IconButton.filled(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailScreen(
                                  productName: widget.productName,
                                  slug: widget.slug,
                                  price: widget.productPrice,
                                  imageUrl: widget.imageUrl,
                                  productDescription: '',
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
  }
}
