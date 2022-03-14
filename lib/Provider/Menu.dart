// ignore_for_file: prefer_final_fields, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Menu extends ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final List catogries;
  bool isFavorite;
  Menu({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.catogries,
    this.isFavorite = false,
  });
  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();

    final hel = FirebaseFirestore.instance.collection('menuItem').doc(id);
    try {
      await hel.update({'isFavorite': isFavorite});
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
