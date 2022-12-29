import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductService extends ChangeNotifier {
  final String baseurl = 'products-app-61f58-default-rtdb.firebaseio.com';
  final List<Product> products = [];
}