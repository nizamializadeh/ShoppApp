import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  int? id;
  String? icon;
  String? title;

  Category({this.id, this.icon, this.title});

// map json to comment model
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
    );
  }

  int? get sayacx => id;

  void sayac(int id1) {
    id = id1;
    notifyListeners();
  }
}
