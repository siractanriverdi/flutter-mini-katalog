/// Ürün veri modeli.
///
/// JSON'dan nesneye (fromJson) ve nesneden JSON'a (toJson) dönüşüm
/// mantığını gösterir (Eğitim - Gün 4 konusu).
class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String image;
  final String description;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.specs,
  });

  /// JSON (Map) -> Product nesnesi
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String,
      specs: Map<String, String>.from(json['specs'] as Map),
    );
  }

  /// Product nesnesi -> JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'image': image,
      'description': description,
      'specs': specs,
    };
  }

  /// Fiyatı "2.499,90 TL" biçiminde döndürür (paket kullanmadan).
  String get priceText {
    final parts = price.toStringAsFixed(2).split('.');
    final digits = parts[0];
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return '$buffer,${parts[1]} TL';
  }
}
