import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ProductModel.dart';

class ProductController extends GetxController{
    var products = [].obs;
    var isLoading = true.obs;

    void fetchProducts(String categoryName) async{
      try{
        final response = await http.get(Uri.parse('http://127.0.0.1:9000/api/category/products/${categoryName}'));
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