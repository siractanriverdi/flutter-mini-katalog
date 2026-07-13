import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';

/// Ana sayfa: banner, kısa tanıtım ve öne çıkan ürünler.
/// Buradan ürün listesi sayfasına geçilir (Navigator - Gün 3 konusu).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final renkler = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TeknoKatalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Sepet',
            onPressed: () => Navigator.pushNamed(context, '/sepet'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner görseli (asset yönetimi)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/banner.png',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Hoş geldin! 👋',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Mini kataloğumuzda 8 ürün seni bekliyor. '
            'Listeye göz at, detayına in, sepetine ekle.',
            style: TextStyle(color: renkler.outline),
          ),
          const SizedBox(height: 16),
          // Ürün listesine geçiş butonu
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/urunler'),
            icon: const Icon(Icons.grid_view_rounded),
            label: const Text('Tüm Ürünlere Göz At'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Öne Çıkanlar',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Öne çıkan ürünler: yatay kaydırılabilir liste
          SizedBox(
            height: 190,
            child: FutureBuilder<List<Product>>(
              future: ProductRepository.loadProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final urunler = snapshot.data!.take(4).toList();
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: urunler.length,
                  itemBuilder: (context, index) {
                    final urun = urunler[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 140,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            // Detay sayfasına ürünü argüman olarak taşı
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/detay',
                              arguments: urun,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    urun.image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        urun.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        urun.priceText,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: renkler.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
