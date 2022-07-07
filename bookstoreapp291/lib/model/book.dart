import 'dart:io';

class Book {
  final String id;
  final String bookName;
  final String bookDescription;
  final int bookAmount;
  final String bookImage;

  Book.set(
      {required this.id,
      required this.bookName,
      required this.bookDescription,
      required this.bookAmount,
      required this.bookImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book.set(
        id: json['_id'],
        bookName: json['bookName'],
        bookDescription: json['bookDescription'],
        bookAmount: json['bookAmount'],
        bookImage: json['bookImage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'bookName': bookName,
      'bookDescription': bookDescription,
      'bookAmount': bookAmount,
      'bookImage': bookImage
    };
  }
}
