import '../models/product.dart';

/// Basit sepet simülasyonu (Eğitim - Gün 5 konusu).
///
/// Gerçek bir e-ticaret altyapısı yoktur; amaç "state güncelleme"
/// mantığını göstermektir. Ekstra paket kullanılmadığı için sepet,
/// uygulama boyunca yaşayan statik bir liste olarak tutulur.
class Cart {
  Cart._(); // nesne oluşturulmasın, sadece statik üyeler kullanılsın

  /// Sepetteki ürünler
  static final List<Product> items = [];

  /// Sepetteki ürün adedi
  static int get count => items.length;

  /// Sepet toplam tutarı
  static double get total =>
      items.fold(0, (toplam, urun) => toplam + urun.price);

  /// Toplamı "27.999,00 TL" biçiminde döndürür.
  static String get totalText {
    final parts = total.toStringAsFixed(2).split('.');
    final digits = parts[0];
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return '$buffer,${parts[1]} TL';
  }

  static void add(Product product) => items.add(product);

  static void removeAt(int index) => items.removeAt(index);

  static void clear() => items.clear();
}
