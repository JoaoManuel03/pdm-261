import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  // Mapa usando o id do produto como chave, evitando duplicatas.
  final Map<int, CartItem> _items = {};

  // ---------- Leitura do estado ----------

  List<CartItem> get items => _items.values.toList(growable: false);

  bool get isEmpty => _items.isEmpty;

  int get totalItems =>
      _items.values.fold<int>(0, (soma, item) => soma + item.quantity);

  double get totalPrice =>
      _items.values.fold<double>(0.0, (soma, item) => soma + item.subtotal);

  int quantityOf(Product product) => _items[product.id]?.quantity ?? 0;

  // ---------- Ações ----------

  void add(Product product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = CartItem(product: product);
    } else {
      item.quantity++;
    }
    notifyListeners();
  }

  void remove(Product product) {
    final item = _items[product.id];
    if (item == null) return;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}