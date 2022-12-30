import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String baseurl = 'products-app-61f58-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  late Product selectedProduct;

  ProductService() {
    getProducts();
  }

  Future<List<Product>> getProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(baseurl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
      print(products[0].name);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }
}
