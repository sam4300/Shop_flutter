import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
    required this.price,
  });

  void toggleFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

}
