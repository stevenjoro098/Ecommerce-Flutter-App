import 'package:get/get.dart';
import '../models/DeliveryModel.dart'; // Your model file
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryInfoController extends GetxController {
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var street = ''.obs;
  var city = ''.obs;

  var isDataValid = false.obs; // Variable to track validation status

  @override
  void onInit() {
    super.onInit();
    validateStoredData(); // Validate stored data on controller initialization
  }

  Future<void> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName.value);
    await prefs.setString('phoneNumber', phoneNumber.value);
    await prefs.setString('email', email.value);
    await prefs.setString('street', street.value);
    await prefs.setString('city', city.value);
  }
  void validateStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fullName.value = prefs.getString('fullName') ?? '';
    phoneNumber.value = prefs.getString('phoneNumber') ?? '';
    street.value = prefs.getString('street') ?? '';

    // Check if any required field is empty
    if (fullName.value.trim().isEmpty ||
        phoneNumber.value.trim().isEmpty ||
        street.value.trim().isEmpty) {
      isDataValid.value = false;
      Get.snackbar("Error", "Some fields are missing or incomplete.");
    } else {
      isDataValid.value = true;
    }
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
