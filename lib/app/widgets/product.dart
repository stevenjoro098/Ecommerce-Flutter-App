import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double productPrice;

  ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productPrice
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin:const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            child: Image.network(
                imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.favorite)
                    )
                  ],
                ),
                Text(
                  productPrice.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton.icon(
                    onPressed: (){},
                    label: const Text('Add To Cart'),
                    icon: const Icon(Icons.add_shopping_cart),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    minimumSize: const Size(double.infinity, 45)
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
