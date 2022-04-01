import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product with ChangeNotifier {
  String? id;
  String? image;
  String? title;
  String? price;
  String? bgColor;
  String? category_id;

  Product(
      {this.id,
      this.image,
      this.title,
      this.price,
      this.bgColor,
      this.category_id});

// map json to comment model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      price: json['price'],
      bgColor: json['bgColor'],
      category_id: json['category_id'],
    );
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        image = map['image'],
        title = map['title'],
        price = map['price'],
        bgColor = map['bgColor'],
        category_id = map['category_id'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'title': title,
        'price': price,
        'bgColor': bgColor,
        'category_id': category_id,
      };

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);
  UnmodifiableListView<Product> get itemsFavorite =>
      UnmodifiableListView(_itemsFavorite);
  static SharedPreferences? _sharedPref;
  // Card
  List<String> _itemsAsString = [];
  List<Product> _items = [];
  // Favorite
  List<String> _itemsAsStringFavorite = [];
  List<Product> _itemsFavorite = [];

  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    await _sharedPref!.remove('test');
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  Future<void> deleteFavoriteItem(int index) async {
    _itemsFavorite.removeAt(index);
    await _sharedPref!.remove('favorite');
    saveItemsFavoriteToSharedPref(_itemsFavorite);
    notifyListeners();
  }

  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> saveItemsToSharedPref(List<Product> items) async {
    print('saveItemsToSharedPref çalıştı');
    _itemsAsString.clear();

    _sharedPref == null
        ? []
        : _itemsAsString = _sharedPref!.getStringList('test') ?? [];
    for (var item in items) {
      _itemsAsString.add(json.encode(item.toMap()));
    }

    if (_sharedPref != null) _sharedPref!.setStringList('test', _itemsAsString);
  }

  Future<void> loadItemsFromSharedPref() async {
    // List<String> tempList = _sharedPref.getStringList('myCard') ?? [];

    List<String> tempList =
        _sharedPref == null ? [] : _sharedPref!.getStringList('test') ?? [];

    print('tempList:$tempList');
    _items.clear();
    for (var item in tempList) {
      _items.add(Product.fromMap(json.decode(item)));
    }
  }

  Future<void> saveItemsFavoriteToSharedPref(List<Product> items) async {
    print('saveItemsToSharedPref çalıştı1');
    _itemsAsStringFavorite.clear();

    _sharedPref == null
        ? []
        : _itemsAsStringFavorite = _sharedPref!.getStringList('favorite') ?? [];

    for (var item in items) {
      _itemsAsStringFavorite.add(json.encode(item.toMap()));
    }

    if (_sharedPref != null)
      _sharedPref!.setStringList('favorite', _itemsAsStringFavorite);
    print(_itemsAsStringFavorite);
  }

  Future<void> loadItemsFavoriteFromSharedPref() async {
    // List<String> tempList = _sharedPref.getStringList('myCard') ?? [];

    List<String> tempListFavorite =
        _sharedPref == null ? [] : _sharedPref!.getStringList('favorite') ?? [];

    print('tempList:$tempListFavorite');
    _itemsFavorite.clear();
    for (var item in tempListFavorite) {
      _itemsFavorite.add(Product.fromMap(json.decode(item)));
    }
  }
}
