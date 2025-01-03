import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/CartController.dart';
import 'mobileView/CheckOutPage.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                cartController.clearCart();
              },
              icon: const Icon(Icons.remove_shopping_cart_sharp)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx((){
                if(cartController.items.isEmpty){
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.calculate_rounded),
                        title: Text('Total Amount:${cartController.totalAmount.toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey
                          ),),
                      ),
                      Image.asset(
                        'assets/icons/shopping-cart.gif',
                        width: MediaQuery.of(context).size.width * 40,
                        height: 230,
                      ),
                      const Text('Cart Empty',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),)
                    ],
                  );
                }
              else {
                return Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
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
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4,),
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
                                leading:Image.network(cartProduct.imageUrl, width: 70,height: 70,),
                                title:Text(cartProduct.name),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cartProduct.price.toString()),
                                    Row(
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
                                            style: const TextStyle(fontSize: 16),
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
                                  ],
                                ),

                              ),
                            ),
                          );
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.lightGreenAccent,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
              SizedBox(height: 20,),

            ],
          ),
        ),
      )
      );
  }
}
