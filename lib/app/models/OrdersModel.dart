class Order {
  final String orderCode;
  final String userFullName;
  final List<Map<String, dynamic>> items;
  final String email;
  final String address;
  final String city;
  final String totalPrice;
  final DateTime orderDate;



  Order({
    required  this.orderCode,
    required this.userFullName,
    required this.email,
    required this.items,
    required this.address,
    required this.city,
    required this.totalPrice,
    required this.orderDate
  });

  // Convert Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderCode': orderCode,
      'userFullname': userFullName,
      'email': email,
      'items': items,
      'address': address,
      'city': city,
      'total': totalPrice,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  //Convert JSON to Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderCode: json['order_code'],
      userFullName: json['first_name'],
      email: json['email'],
      items: [],//List<Map<String, dynamic>>.from(json['items']),
      address: json['address'],
      totalPrice: json['total'],
      orderDate: DateTime.parse(json['created']),
      city:json['city']
    );
  }
}
