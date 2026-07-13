import 'package:flutter/material.dart';

import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

/// Mini Katalog Uygulaması
///
/// Named Routes (Gün 3 konusu) ile 4 sayfa arasında gezinilir:
///   /         -> Ana sayfa
///   /urunler  -> Ürün listesi (GridView)
///   /detay    -> Ürün detayı (Route Arguments ile ürün taşınır)
///   /sepet    -> Sepet (simülasyon)
class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3250)),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/urunler': (context) => const ProductListPage(),
        '/detay': (context) => const ProductDetailPage(),
        '/sepet': (context) => const CartPage(),
      },
    );
  }
}
