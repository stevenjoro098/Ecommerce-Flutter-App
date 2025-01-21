import 'dart:convert';

import 'package:ecommerce_app/app/views/mobileView/Home/Home.dart';
import 'package:ecommerce_app/app/views/mobileView/LoginPage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_constants.dart';

class AuthenticationController extends GetxController {
  String registerUrl = APIConstants.register;
  String loginUrl = APIConstants.login;
  void registerAccount(
      String firstName,
      String lastName,
      String email,
      String contact,
      String password
      ) async {
    var data = {
      'first_name': firstName,
      'last_name': lastName,
      'email':email,
      'contact_number':contact,
      'password':password
    };
    final response = await http.post(
      Uri.parse(registerUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Order placed successfully
      Get.to(() => LoginPage());

      Get.snackbar('Registration', 'Registered Successfully!!');
      var resp = jsonDecode(response.body);
    } else {
      // API call failed
      Get.snackbar('','Failed to Register');
    }

  }
  void login(String email, String password)async{
    var data = {
      'email': email,
      'password': password
    };
    final response = await http.post(
      Uri.parse(loginUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Order placed successfully

      Get.to(() => HomePage());
      Get.snackbar('Login', 'Welcome!!');
      var resp = jsonDecode(response.body);
    } else {
      // API call failed
      Get.to(() => HomePage());
      Get.snackbar('Login','Failed to Login');
    }
    }
}