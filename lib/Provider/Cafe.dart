import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CafeItem extends ChangeNotifier {
  final String cafeId;
  final String cafeName;
  final String cafeDiscription;
  final String cafeImageUrl;
  final String cafephone;
  final String cafeMail;
  final String cafefacebook;
  CafeItem(
      {required this.cafeId,
      required this.cafeName,
      required this.cafeDiscription,
      required this.cafeImageUrl,
      required this.cafephone,
      required this.cafeMail,
      required this.cafefacebook});
}

class Cafe extends ChangeNotifier {
  List<CafeItem> _listOfCafes = [];

  String _isSelected = '';

  File? pickedImage;

  String get isSelected {
    return _isSelected;
  }

  bool cafeSelected() {
    if (isSelected == '') {
      return false;
    } else {
      return true;
    }
  }

  CafeItem findById() {
    return _listOfCafes.firstWhere((pro) => pro.cafeId == isSelected);
  }

  List<CafeItem> get listOfCafes {
    return [..._listOfCafes];
  }

  void cafeSelection(String cafeId) {
    _isSelected = cafeId;
    notifyListeners();
  }

  Future<void> fetchListOfCafes() async {
    try {
      final List<CafeItem> loadedCafes = [];
      final snap =
          FirebaseFirestore.instance.collection('listOfRestorant').get();
      final response = await snap;
      final extractedData = response.docs.map((e) => e);
      extractedData.forEach((cafeData) {
        loadedCafes.add(CafeItem(
          cafeId: cafeData.id,
          cafeName: cafeData['name'],
          cafeDiscription: cafeData['description'],
          cafeImageUrl: cafeData['imageUrl'],
          cafephone: cafeData['cafephone'],
          cafeMail: cafeData['cafeMail'],
          cafefacebook: cafeData['cafefacebook'],
        ));
        _listOfCafes = loadedCafes;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMenu(CafeItem cafe) async {
    String? imageUrl;
    try {
      if (pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('cafeslogos')
            .child(cafe.cafeName + '.jpg');
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));
        imageUrl = await ref.getDownloadURL();
      }

      final firebase = FirebaseFirestore.instance.collection('listOfRestorant');
      final response = await firebase.add({
        'name': cafe.cafeName,
        'imageUrl': imageUrl,
        'description': cafe.cafeDiscription,
        'cafephone': cafe.cafephone,
        'cafeMail': cafe.cafeMail,
        'cafefacebook': cafe.cafefacebook
      });
      final newMenuItem = CafeItem(
          cafeId: response.id,
          cafeName: cafe.cafeName,
          cafeDiscription: cafe.cafeDiscription,
          cafeImageUrl: imageUrl.toString(),
          cafephone: cafe.cafephone,
          cafeMail: cafe.cafeMail,
          cafefacebook: cafe.cafefacebook);

      _listOfCafes.add(newMenuItem);

      pickedImage = null;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clear() {
    _listOfCafes.clear();
    notifyListeners();
  }

  void deleteCafeItem(String cafeId, String cafeName) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('cafeslogos')
        .child(cafeName + '.jpg');
    final firebase =
        FirebaseFirestore.instance.collection('listOfRestorant').doc(cafeId);
    final existingProductIndex =
        _listOfCafes.indexWhere((element) => element.cafeId == cafeId);
    var existingProduct = _listOfCafes[existingProductIndex];

    firebase.delete().then((response) async {
      _listOfCafes.removeAt(existingProductIndex);
      await ref.delete();
      // notifyListeners();
      existingProduct.dispose();
    }).catchError((_) {
      _listOfCafes.insert(existingProductIndex, existingProduct);
      // notifyListeners();
    });
    _listOfCafes.removeAt(existingProductIndex);
    notifyListeners();
  }
}
