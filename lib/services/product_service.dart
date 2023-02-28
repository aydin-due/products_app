import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String baseurl = 'products-app-61f58-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  late Product selectedProduct;
  File? image;

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

  Future saveProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(baseurl, 'products/${product.id}.json');
    await http.put(url, body: product.toJson());
    products[products.indexWhere((element) => element.id == product.id)] =
        product;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(baseurl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);
    product.id = decodedData['name'];
    products.add(product);
    return decodedData['name'];
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    image = File.fromUri(Uri(path: path));
    notifyListeners();
  }
}
