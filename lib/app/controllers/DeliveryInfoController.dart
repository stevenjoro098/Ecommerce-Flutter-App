import 'package:get/get.dart';
import '../models/DeliveryModel.dart'; // Your model file
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryInfoController extends GetxController {
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var street = ''.obs;
  var city = ''.obs;

  Future<void> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName.value);
    await prefs.setString('phoneNumber', phoneNumber.value);
    await prefs.setString('email', email.value);
    await prefs.setString('street', street.value);
    await prefs.setString('city', city.value);
  }

  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    fullName.value = prefs.getString('fullName') ?? '';
    phoneNumber.value = prefs.getString('phoneNumber') ?? '';
    email.value = prefs.getString('email') ?? '';
    street.value = prefs.getString('street') ?? '';
    city.value = prefs.getString('city') ?? '';
  }
}
