import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

/// Ürün listesi sayfası.
/// - JSON'dan yüklenen ürünleri GridView ile listeler (Gün 4-5)
/// - Basit arama/filtreleme içerir (Gün 4)
/// - AppBar'daki sepet rozeti state güncellemeyi gösterir (Gün 5)
class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _aramaMetni = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        actions: [
          // Sepet ikonu + adet rozeti
          IconButton(
            tooltip: 'Sepet',
            icon: Badge(
              isLabelVisible: Cart.count > 0,
              label: Text('${Cart.count}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () async {
              await Navigator.pushNamed(context, '/sepet');
              // Sepet sayfasından dönünce rozet güncellensin
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama kutusu
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (deger) => setState(() => _aramaMetni = deger),
              decoration: InputDecoration(
                hintText: 'Ürün veya kategori ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: ProductRepository.loadProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ürünler yüklenirken bir sorun oluştu.'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Basit filtreleme: ada veya kategoriye göre
                final sorgu = _aramaMetni.toLowerCase();
                final urunler = snapshot.data!.where((u) {
                  return u.name.toLowerCase().contains(sorgu) ||
                      u.category.toLowerCase().contains(sorgu);
                }).toList();

                if (urunler.isEmpty) {
                  return const Center(
                    child: Text('Aramanla eşleşen ürün bulunamadı.'),
                  );
                }

                // GridView ile kart tabanlı tasarım
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: urunler.length,
                  itemBuilder: (context, index) {
                    final urun = urunler[index];
                    return ProductCard(
                      product: urun,
                      // Detay sayfasına Route Arguments ile ürünü taşı
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/detay',
                          arguments: urun,
                        );
                        setState(() {}); // detaydan dönünce rozeti tazele
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
