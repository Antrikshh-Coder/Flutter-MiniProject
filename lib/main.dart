import 'package:flutter/material.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const ShopEaseApp());
}

class ShopEaseApp extends StatefulWidget {
  const ShopEaseApp({super.key});

  @override
  State<ShopEaseApp> createState() => _ShopEaseAppState();
}

class _ShopEaseAppState extends State<ShopEaseApp> {
  final CartState _cartState = CartState();

  @override
  void dispose() {
    _cartState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cartState: _cartState,
      child: MaterialApp(
        title: 'ShopEase – E-Commerce Shopping Cart',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
