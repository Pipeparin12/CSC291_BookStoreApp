import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<String> category;
  final double rating, price;

  Product({
    required this.id,
    required this.images,
    required this.category,
    this.rating = 0.0,
    required this.title,
    required this.price,
    required this.description,
  });
}
