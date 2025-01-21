import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/CartController.dart';
import '../mobileView/CheckOutPage.dart';

class CartPageDesktop extends StatelessWidget {
  final CartController cartController = Get.find();
  CartPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                    itemCount: cartController.items.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var cartProduct = cartController.items.values.toList()[index];
                      return Dismissible(
                        key: Key(cartProduct.slug),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),

                        ),
                        onDismissed: (direction){
                          //Remove the item for the cart
                          cartController.removeItem(cartProduct.slug);
                          Get.snackbar('Item Removed',
                            "${cartProduct.name} has been removed from the cart.",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 2,
                          child: ListTile(
                            leading:ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  cartProduct.imageUrl,
                                  width: 75,
                                  height: 95,
                                  fit: BoxFit.fill,
                                )
                            ),
                            title:Text(cartProduct.name,style: TextStyle(fontSize:19,fontWeight: FontWeight.bold),),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cartProduct.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle),
                                        onPressed: () {
                                          if (cartProduct.quantity.value > 1) {
                                            cartProduct.quantity.value--;
                                          } else {
                                            cartController.removeItem(cartProduct.slug);
                                          }
                                        },
                                      ),
                                      Obx(() {
                                        return Text(
                                          "${cartProduct.quantity.value}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        );
                                      }),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle),
                                        onPressed: () {
                                          cartProduct.quantity.value++;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          Card(
            child: SafeArea(
              child: Entry.all(
                duration: Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text('Cart Overview'),
                      const Text('Total Amount.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        cartController.totalAmount.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: (){
                          Get.to(() => CheckOutPage());
                        },
                        icon: Icon(Icons.check),
                        label: const Text('CheckOut',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          // padding: const EdgeInsets.symmetric(
                          //   vertical: 12.0,
                          //   horizontal: 20.0,
                          // ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.lightGreenAccent,
                          //minimumSize: const Size(double.infinity, 50),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
