// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      user});
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  int itemQuantity(String itemId) {
    if (_items[itemId] == null) {
      return 0;
    } else {
      return _items[itemId]!.quantity;
    }
  }

  List<String> _menuIds = [];

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingValue) => CartItem(
              id: existingValue.id,
              title: existingValue.title,
              quantity: existingValue.quantity + 1,
              price: existingValue.price));
    } else {
      _items.putIfAbsent(productId, () {
        _menuIds.add(productId);
        return CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        );
      });
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear(/*String? userId*/) {
    // final hel = FirebaseFirestore.instance.collection('users').doc(userId);
    // await hel.update({'history': _menuIds});
    _items = {};
    notifyListeners();
  }
}
