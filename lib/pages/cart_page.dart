import 'package:flutter/material.dart';

import '../data/cart.dart';

/// Sepet sayfası (simülasyon).
/// Sepetteki ürünleri listeler, çıkarma ve "satın alma" ile
/// state güncelleme mantığını gösterir.
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final renkler = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: Cart.items.isEmpty
          // Boş sepet durumu
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 72, color: renkler.outlineVariant),
                  const SizedBox(height: 12),
                  const Text('Sepetin boş.'),
                  const SizedBox(height: 4),
                  Text(
                    'Ürün listesinden sepete ürün ekleyebilirsin.',
                    style: TextStyle(color: renkler.outline),
                  ),
                ],
              ),
            )
          // Sepetteki ürünlerin listesi
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: Cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final urun = Cart.items[index];
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(urun.image,
                          width: 52, height: 52, fit: BoxFit.cover),
                    ),
                    title: Text(urun.name),
                    subtitle: Text(urun.priceText),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      tooltip: 'Sepetten çıkar',
                      onPressed: () {
                        setState(() => Cart.removeAt(index));
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Cart.items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Toplam',
                              style: TextStyle(color: renkler.outline)),
                          Text(
                            Cart.totalText,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(Cart.clear);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Siparişin alındı! (Bu bir simülasyondur)'),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 16),
                      ),
                      child: const Text('Satın Al'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
