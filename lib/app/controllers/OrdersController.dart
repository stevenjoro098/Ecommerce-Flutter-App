import 'dart:ffi';

import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/OrdersModel.dart';
import '../controllers/CartController.dart';
import '../views/mobileView/OrdersPage.dart';

class OrderController extends GetxController {
  var userfullname = ''.obs;
  var items = <Map<String, dynamic>>[].obs;
  var ordersList = <Order>[].obs;
  var deliveryAddress = ''.obs;
  var email = ''.obs;
  var totalPrice = ''.obs;
  var orderDate = DateTime.now().obs;
  var isDataValid = true.obs;
  CartController cartController = Get.find();
  DeliveryInfoController deliveryInfoController = Get.find();

  @override
  void onInit(){
    super.onInit();
    fetchOrdersList();
  }
  // Method to add item to the order
  void addItem(String productId, String productName, int quantity, double price) {
    items.add({
      'id': productId,
      'name': productName,
      'quantity': quantity,
      'price': price,
    });
    updateTotalPrice();
  }

  // Method to calculate total price based on items
  void updateTotalPrice() {
    double total = 0.0;
    for (var item in items) {
      total += item['price'] * item['quantity'];
    }
    totalPrice.value = total.toString();
  }

  // Method to validate the order data
  // bool validateOrderData() {
  //   if (deliveryAddress.isEmpty || items.isEmpty || userfullname.isEmpty) {
  //     isDataValid.value = false;
  //     Get.snackbar('Error', 'Missing Info.');
  //     return false;
  //   }
  //   isDataValid.value = true;
  //   return true;
  // }

  // Method to place an order
  Future<void> placeOrder(
      String userfullname,
      String phone,
      String email,
      String city,
      String street
      ) async {
    // if (!validateOrderData()) {
    //   // Data is invalid, cannot place the order
    //   print('Invalid Data');
    //   print(userfullname);
    //   print(email);
    //   print(phone);
    //   print(city);
    //   print(items);
    //   return;
    // }

    // Create the order model
    final order = Order(
      userFullName: userfullname,
      items: items,
      email: email,
      address: deliveryAddress.value,
      totalPrice: totalPrice.value,
      orderDate: orderDate.value, 
      city: city,
      orderCode: '',
    );

    // Call API to place the order (replace with actual API endpoint)
    final response = await http.post(
      Uri.parse('http://127.0.0.1:9000/orders/api/create'),
      body: jsonEncode(order.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Order placed successfully
      print('Order placed successfully');
      var resp = jsonDecode(response.body);
      String orderCode = resp['order_code'];
      String firstName = resp['first_name'];
      String email = resp['email'];
      String address=resp['address'];
      String total=resp['total'];
      String created=resp['created'];
      bool paid=resp['paid'];

      Get.to(()=>OrdersPageView(
                  orderCode: orderCode,
                  firstName:firstName,
                  email:email,
                  address:address,
                  total:total,
                  created:created,
                  paid:paid
                  ));
      cartController.clearCart();
      items.clear();
    } else {
      // API call failed
      print('Failed to place the order');
    }
  }

  Future<void> fetchOrdersList() async{
    var email = deliveryInfoController.email.value;
    final response = await http.post(
      Uri.parse('http://127.0.0.1:9000/orders/api/orders/list'),
      body: jsonEncode({"email": email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Order placed successfully
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['resp'] != null) {
      List<dynamic> respList = jsonResponse['resp'];
      ordersList.value = respList.map((json) => Order.fromJson(json)).toList();
    } else {
      print('No orders found in response');
    }
      // API call failed
      print('Failed to fetch orders list');
    }
  }
}
