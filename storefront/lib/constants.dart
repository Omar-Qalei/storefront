import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storefront/models/product.model.dart';

late PageController controller;

const primaryColor = Color(0xFFFFFFFF);
const pinkColor = Color(0xFFEF5E9F);
const secondaryColor = Color(0xFF454d5a);
const bgColor = Color(0xFF333742);
const bgLightColor = Color(0xFF555863);
const grayColor = Color(0xFF8b8d94);
ProductModel products = ProductModel(data: []);
void getJsonBin() async {
  controller = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 0.8,
  );
  String product = "https://fakestoreapi.com/products";
  await http.get(Uri.parse(product), headers: {}).then((value) {
    ProductModel productModel = ProductModelFromJson(value.body);
    products = productModel;
  }).catchError((err) {
    print('err: $err');
  });
}
