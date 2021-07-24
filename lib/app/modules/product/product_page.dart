import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final String id;
  const ProductPage({Key? key, this.title = 'ProductPage', required this.id})
      : super(key: key);
  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
