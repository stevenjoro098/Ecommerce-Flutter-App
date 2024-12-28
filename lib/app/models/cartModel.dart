import 'package:get/get.dart';

class CartItem {
  final String slug;
  final String imageUrl;
  final String name;
  final double price;
  RxInt quantity;

  CartItem({
    required this.slug,
    required this.imageUrl,
    required this.name,
    required this.price,
    int quantity = 1,
  }) : quantity = quantity.obs;
}