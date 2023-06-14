import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shoes_shop/models/shoe.dart';

class ShoeProvider extends ChangeNotifier {
  static const String url = "https://shoe-api-9pag.onrender.com/shoes";
  List<Shoe> _shoes = [];

  List<Shoe> get shoes => _shoes;
  Future<void> getAllProductsServerandSaveLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    if (box.isEmpty) {
      try {
        final response = await http.get(Uri.parse(url));

        var list = json.decode(response.body) as List<dynamic>;

        List<Shoe> data = list.map((e) => Shoe.fromJson(e)).toList();

        for (int i = 0; i < data.length; i++) {
          await box.add(data[i]);
        }
      } catch (e) {
        print(e);
        _shoes = [];
      }
    }
    await getAllShoesLocal();
    notifyListeners();
  }

  getAllShoesLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');

    _shoes = box.values.toList();
    print(_shoes.toString());
    notifyListeners();
  }

    Future<void> updateShoeLocal(Shoe shoe, int index) async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    box.putAt(index, shoe);
    notifyListeners();
  }
  
}
