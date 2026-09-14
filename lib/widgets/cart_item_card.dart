import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../utils/app_theme.dart';
import 'product_image_view.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final product = cartItem.product;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 75,
                height: 75,
                child: ProductImageView(product: product),
              ),
            ),
            const SizedBox(width: 14),

            // Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price.toStringAsFixed(0)} each',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Quantity Controls
                  Row(
                    children: [
                      _buildQtyBtn(
                        icon: Icons.remove,
                        onTap: () {
                          cart.updateQuantity(
                            product.id,
                            cartItem.quantity - 1,
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      _buildQtyBtn(
                        icon: Icons.add,
                        onTap: () {
                          cart.updateQuantity(
                            product.id,
                            cartItem.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Item Total & Delete Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppTheme.errorColor,
                    size: 22,
                  ),
                  onPressed: () {
                    cart.removeFromCart(product.id);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} removed from cart'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        width: 320,
                      ),
                    );
                  },
                  tooltip: 'Remove Item',
                ),
                Text(
                  '₹${cartItem.itemTotal.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Icon(icon, size: 16, color: AppTheme.textPrimary),
      ),
    );
  }
}
