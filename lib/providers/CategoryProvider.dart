import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  String _selectedSubcategory = "All";

  String get selectedSubcategory => _selectedSubcategory;

  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
  }

  void setSelectedSubcategory(String item){
    _selectedSubcategory = item;
    notifyListeners();
  }

  void fetchCategories() {
    List<Category> fetchCategories = [];
    FirebaseFirestore.instance
        .collection('categories')
        .orderBy('name')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        fetchCategories.add(new Category(
            id: element.id,
            name: element['name'],
            subcategories: List<String>.from(element['subcategories'])));
      });

      _categories = fetchCategories;
      notifyListeners();
    });
  }
}
