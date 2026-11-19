import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../state/cart_provider.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            icon: Badge(
              label: Text('${cart.totalItems}'),
              isLabelVisible: cart.totalItems > 0,
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        itemCount: kProducts.length,
        itemBuilder: (context, index) {
          final product = kProducts[index];
          final quantidade = cart.quantityOf(product);

          return ListTile(
            leading: Text(product.emoji, style: const TextStyle(fontSize: 32)),
            title: Text(product.name),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: quantidade == 0
                ? FilledButton(
                    onPressed: () => context.read<CartProvider>().add(product),
                    child: const Text('Adicionar'),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () =>
                            context.read<CartProvider>().remove(product),
                      ),
                      Text('$quantidade',
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () =>
                            context.read<CartProvider>().add(product),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}