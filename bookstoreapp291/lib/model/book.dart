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

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book.set(
        id: data['_id'],
        bookName: data['bookName'],
        bookDescription: data['bookDescription'],
        bookAmount: data['bookAmount'],
        bookImage: data['bookImage']);
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
