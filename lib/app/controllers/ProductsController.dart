import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ProductModel.dart';
import '../utils/api_constants.dart';

class ProductController extends GetxController{
    var products = [].obs;
    var isLoading = true.obs;
    String categoryProductsUrl = APIConstants.category;
    void fetchProducts(String categoryName) async{
      try{
        final response = await http.get(Uri.parse('${categoryProductsUrl}${categoryName}'));
        if(response.statusCode==200){
          Future.delayed(Duration(seconds: 1), (){
            final List<dynamic> data = jsonDecode(response.body);
            products.value = data.map((json) => Product.fromJson(json)).toList();
          }
          );

          }
        else{

        }
      } catch(e){

      } finally {
        isLoading(false);
    }

    }
}