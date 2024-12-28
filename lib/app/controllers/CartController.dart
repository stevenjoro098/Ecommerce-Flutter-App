import 'package:ecommerce_app/app/models/cartModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var items = <String, CartItem>{}.obs;

  void addItem(String slug, String imageUrl, String name, double price){
      if(items.containsKey(slug)){
        //update quantity if item already exists
        items[slug]!.quantity++;
        Get.snackbar('Item', 'Cart Updated');
      } else {
        //add new item
        items[slug] = CartItem(slug: slug, imageUrl: imageUrl, name: name, price: price);
        Get.snackbar("$name ", 'Added to Cart');
      }

  }

  // remove an item form the cart
  void removeItem(String slug){
      items.remove(slug);
  }

  //remove clear cart
  void clearCart(){
    items.clear();
  }

  double get totalAmount => items.values
      .fold(0.0, (sum, item) => sum + (item.price * item.quantity.value));

  int get itemCount => items.values.fold(0, (sum, item) => sum + item.quantity.value);

}