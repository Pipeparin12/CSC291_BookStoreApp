import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name, description;
  final String images;
  final double rating, price;
  final bool isBookmark;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isBookmark = false,
    required this.name,
    required this.price,
    required this.description,
  });
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: 'images/the_help_book.png',
    name: "The Help",
    price: 200,
    description: description,
    rating: 4.8,
    isBookmark: true,
  ),
  Product(
    id: 2,
    images: "images/the_kite_runner_book.png",
    name: "The Kite Runner",
    price: 245,
    description: description,
    rating: 4.1,
  ),
  Product(
    id: 3,
    images: "images/water_for_elephant_book.png",
    name: "Water for Elephants",
    price: 150,
    description: description,
    rating: 4.1,
  ),
  Product(
    id: 4,
    images: "images/the_book_thief.png",
    name: "The Book Thief",
    price: 299,
    description: description,
    rating: 4.1,
    isBookmark: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
