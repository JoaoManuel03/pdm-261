import 'package:flutter_test/flutter_test.dart';
import 'package:loja_carrinho/data/products.dart';
import 'package:loja_carrinho/state/cart_provider.dart';

void main() {
  test('adiciona e remove itens do carrinho', () {
    final cart = CartProvider();
    final maca = kProducts.first;

    cart.add(maca);
    cart.add(maca);
    expect(cart.totalItems, 2);
    expect(cart.totalPrice, closeTo(5.0, 0.001));

    cart.remove(maca);
    expect(cart.quantityOf(maca), 1);
  });
}