import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/DeliveryInfoController.dart';

class DeliveryForm extends StatelessWidget {
  final DeliveryInfoController deliveryController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Fill the Form Below:", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              TextFormField(
                onChanged: (value) => deliveryController.fullName.value = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_outlined),
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                controller: TextEditingController(
                  text: deliveryController.fullName.value,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) =>
                deliveryController.phoneNumber.value = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone Number is required';
                  }
                  if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                controller: TextEditingController(
                  text: deliveryController.phoneNumber.value,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => deliveryController.email.value = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
                controller: TextEditingController(
                  text: deliveryController.email.value,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => deliveryController.street.value = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Street address is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.streetview),
                  labelText: 'Street',
                  hintText: 'Enter your street address',
                ),
                controller: TextEditingController(
                  text: deliveryController.street.value,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => deliveryController.city.value = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  labelText: 'City',
                  hintText: 'Enter your city',
                ),
                controller: TextEditingController(
                  text: deliveryController.city.value,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await deliveryController.saveToSharedPreferences();
                        Get.snackbar("Success", "Delivery information Saved!");
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Save"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
