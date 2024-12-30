class DeliveryInfo {
  String fullName;
  String phoneNumber;
  String email;
  String street;
  String city;
  String state;
  String zipCode;
  String country;
  String deliveryInstructions;

  DeliveryInfo({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.deliveryInstructions = '',
  });

  // Optional: Convert to/from JSON for API or local storage
  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "email": email,
    "street": street,
    "city": city,
    "state": state,
    "zipCode": zipCode,
    "country": country,
    "deliveryInstructions": deliveryInstructions,
  };

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    fullName: json['fullName'],
    phoneNumber: json['phoneNumber'],
    email: json['email'],
    street: json['street'],
    city: json['city'],
    state: json['state'],
    zipCode: json['zipCode'],
    country: json['country'],
    deliveryInstructions: json['deliveryInstructions'] ?? '',
  );
}
