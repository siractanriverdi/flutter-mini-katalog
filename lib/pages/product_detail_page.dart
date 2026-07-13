import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';

/// Ürün detay sayfası.
/// - Ürün bilgisi Route Arguments ile taşınır (Gün 3 konusu)
/// - "Sepete Ekle" butonu basit state güncellemeyi gösterir (Gün 5)
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Bir önceki sayfadan gönderilen ürünü al (Route Arguments)
    final urun = ModalRoute.of(context)!.settings.arguments as Product;
    final renkler = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(urun.name)),
      body: ListView(
        children: [
          Image.asset(
            urun.image,
            height: 280,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori etiketi
                Chip(
                  label: Text(urun.category),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(height: 8),
                Text(
                  urun.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  urun.priceText,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: renkler.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text('Açıklama',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(
                  urun.description,
                  style: TextStyle(height: 1.5, color: renkler.onSurface),
                ),
                const SizedBox(height: 16),
                Text('Özellikler',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                // Özellikleri satır satır listele
                ...urun.specs.entries.map(
                  (ozellik) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 18, color: renkler.primary),
                        const SizedBox(width: 8),
                        Text('${ozellik.key}: ',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Expanded(child: Text(ozellik.value)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Sepete ekle butonu
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            onPressed: () {
              setState(() => Cart.add(urun)); // state güncelleme (simülasyon)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${urun.name} sepete eklendi. Sepette ${Cart.count} ürün var.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Sepete Ekle'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }
}
