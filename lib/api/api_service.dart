import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  dynamic products;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    final response = await Dio().get('http://10.0.2.2:8000/api/products');
    products = response.data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: products == null ? 0 : products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Image.network(
                    products[index]['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: <Widget>[
                      Text(products[index]['name']),
                      Text(products[index]['description']),
                      Text(products[index]['price']),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
