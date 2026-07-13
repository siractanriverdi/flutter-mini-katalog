import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// Ürün verilerini assets içindeki JSON dosyasından okur.
///
/// Gerçek bir API çağrısının simülasyonudur: uzak sunucu yerine
/// assets/data/products.json dosyası "veri kaynağı" olarak kullanılır.
class ProductRepository {
  static List<Product>? _cache;

  /// Tüm ürünleri yükler. İlk çağrıda dosyadan okur, sonra önbellekten döner.
  static Future<List<Product>> loadProducts() async {
    if (_cache != null) return _cache!;

    final jsonString = await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

    _cache = jsonList
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
    return _cache!;
  }
}
