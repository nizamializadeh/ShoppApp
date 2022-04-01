import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/Product.dart';
import 'package:shopping_app/screens/loading.dart';

void main() async {
  runApp(Provider<Product>(
      create: (BuildContext context) {
        return Product();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Product(), // ← create/init your state model
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Loading(),
      ),
    );
  }
}
