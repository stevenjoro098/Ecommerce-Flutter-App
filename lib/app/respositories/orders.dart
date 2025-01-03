import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/OrdersModel.dart';

class OrderApiRepository {
  final String apiUrl;

  OrderApiRepository({required this.apiUrl});

  Future<void> uploadOrder(Order order) async {
    final url = Uri.parse('http>//127.0.0.1:9000/orders/create');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to upload order: ${response.body}');
    }
  }
}
