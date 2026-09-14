import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Pure Flutter state management using ChangeNotifier & InheritedNotifier.
/// No external third-party state management package required.
class CartState extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount {
    int count = 0;
    for (var item in _items) {
      count += item.quantity;
    }
    return count;
  }

  double get subtotal {
    double total = 0.0;
    for (var item in _items) {
      total += item.itemTotal;
    }
    return total;
  }

  double get discount {
    if (subtotal > 0) {
      return (subtotal * 0.05).roundToDouble(); // 5% discount
    }
    return 0.0;
  }

  double get deliveryFee => 0.0; // FREE Delivery

  double get grandTotal => subtotal - discount + deliveryFee;

  void addToCart(Product product, {int quantity = 1}) {
    int index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    int index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartScope extends InheritedNotifier<CartState> {
  const CartScope({
    super.key,
    required CartState cartState,
    required super.child,
  }) : super(notifier: cartState);

  static CartState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope found in context');
    return scope!.notifier!;
  }
}
