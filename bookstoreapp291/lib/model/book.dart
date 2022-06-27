import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? name;
  String? description;
  String? price;
  int? amount;
  String? image;

  Book({this.name, this.description, this.price, this.amount, this.image});
}
