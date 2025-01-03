import 'package:ecommerce_app/app/widgets/OrderCard.dart';
import 'package:flutter/material.dart';

class OrdersPageView extends StatefulWidget {
  final String orderCode;
  final String firstName;
  final String email;
  final String address;
  final double total;
  final String created;
  final bool paid;
  const OrdersPageView({
    super.key,
    required this.orderCode,
    required this.firstName,
    required this.email,
    required this.address,
    required this.total,
    required this.created,
    required this.paid
    });

  @override
  State<OrdersPageView> createState() => _OrdersPageViewState();
}

class _OrdersPageViewState extends State<OrdersPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OrderCard(
                  orderCode: widget.orderCode,
                  name: widget.firstName,
                  email: widget.email,
                  created: widget.created,
                  total: widget.total,
                  paid: widget.paid
              )
            ],
          ),
        ),
      ),
    );
  }
}
