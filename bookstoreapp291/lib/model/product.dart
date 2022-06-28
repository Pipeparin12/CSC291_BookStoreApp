import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String name, description, price;
  final String images;
  final double rating;
  final bool isBookmark;
  final int amount;

  Product({
    required this.images,
    this.rating = 0.0,
    this.isBookmark = false,
    required this.name,
    required this.price,
    required this.description,
    required this.amount,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product books = Product(
        images: snap['image'],
        name: snap['bookName'],
        price: snap['bookPrice'],
        description: snap['bookDes'],
        amount: snap['bookAmount']);
    return books;
  }
}

List<Product> demoProducts = [
  Product(
    images: 'images/the_help_book.png',
    name: "The Help",
    price: '200',
    description: description,
    rating: 4.8,
    isBookmark: true,
    amount: 3,
  ),
  Product(
    images: "images/the_kite_runner_book.png",
    name: "The Kite Runner",
    price: '245',
    description: description,
    rating: 4.1,
    amount: 2,
  ),
  Product(
    images: "images/water_for_elephant_book.png",
    name: "Water for Elephants",
    price: '150',
    description: description,
    rating: 4.1,
    amount: 1,
  ),
  Product(
    images: "images/the_book_thief.png",
    name: "The Book Thief",
    price: '299',
    description: description,
    rating: 4.1,
    isBookmark: true,
    amount: 4,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
