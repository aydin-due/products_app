import 'package:flutter/material.dart';
import 'package:products_app/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: ((BuildContext context, index) => GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'product'),
              child: const ProductCard()))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
