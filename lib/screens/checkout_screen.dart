import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/order_model.dart';
import '../providers/cart_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/responsive_container.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  String _paymentMethod = 'Cash on Delivery';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  String _generateOrderId() {
    final random = Random();
    final number = 100 + random.nextInt(900);
    return 'SE20260914$number';
  }

  void _submitOrder() {
    final cart = CartScope.of(context);
    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty! Add items to checkout.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final orderId = _generateOrderId();

      final order = OrderModel(
        orderId: orderId,
        items: List.from(cart.items),
        customerName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        pinCode: _pinController.text.trim(),
        paymentMethod: _paymentMethod,
        subtotal: cart.subtotal,
        discount: cart.discount,
        totalAmount: cart.grandTotal,
        orderDate: DateTime.now(),
      );

      // Navigate to Order Confirmation Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(order: order),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Details'),
      ),
      body: ResponsiveContainer(
        maxWidth: 1050,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Form & Payment
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDeliverySection(),
                            const SizedBox(height: 24),
                            _buildPaymentSection(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Right Column: Order Summary
                      Expanded(
                        flex: 2,
                        child: _buildOrderSummaryCard(cart),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDeliverySection(),
                      const SizedBox(height: 24),
                      _buildPaymentSection(),
                      const SizedBox(height: 24),
                      _buildOrderSummaryCard(cart),
                      const SizedBox(height: 30),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.location_on_outlined,
          title: 'Delivery Address',
        ),
        const SizedBox(height: 16),

        // Full Name
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'John Doe',
            prefixIcon: Icon(Icons.person_outline),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),

        // Phone & Email Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '9876543210',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  if (value.trim().length != 10) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'john@example.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email address';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Delivery Address
        TextFormField(
          controller: _addressController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Delivery Address',
            hintText: 'Flat / House No., Street, Area',
            prefixIcon: Icon(Icons.home_outlined),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your delivery address';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),

        // City & PIN Code Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Mumbai',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextFormField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: const InputDecoration(
                  labelText: 'PIN Code',
                  hintText: '400001',
                  prefixIcon: Icon(Icons.pin_drop_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a valid 6-digit PIN code';
                  }
                  if (value.trim().length != 6) {
                    return 'Enter a valid 6-digit PIN code';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.payment_outlined,
          title: 'Payment Method',
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              // ignore: deprecated_member_use
              RadioListTile<String>(
                value: 'Cash on Delivery',
                // ignore: deprecated_member_use
                groupValue: _paymentMethod,
                title: const Text('Cash on Delivery (COD)'),
                subtitle: const Text('Pay with cash when order arrives'),
                secondary: const Icon(Icons.payments_outlined,
                    color: AppTheme.primaryColor),
                // ignore: deprecated_member_use
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  }
                },
              ),
              const Divider(height: 1),
              // ignore: deprecated_member_use
              RadioListTile<String>(
                value: 'UPI / QR Code',
                // ignore: deprecated_member_use
                groupValue: _paymentMethod,
                title: const Text('UPI Payment'),
                subtitle: const Text('Google Pay, PhonePe, Paytm, BHIM'),
                secondary: const Icon(Icons.qr_code_2_rounded,
                    color: AppTheme.primaryColor),
                // ignore: deprecated_member_use
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  }
                },
              ),
              const Divider(height: 1),
              // ignore: deprecated_member_use
              RadioListTile<String>(
                value: 'Credit / Debit Card',
                // ignore: deprecated_member_use
                groupValue: _paymentMethod,
                title: const Text('Credit / Debit Card'),
                subtitle: const Text('Visa, Mastercard, RuPay'),
                secondary: const Icon(Icons.credit_card_outlined,
                    color: AppTheme.primaryColor),
                // ignore: deprecated_member_use
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummaryCard(CartState cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.receipt_long_outlined,
          title: 'Order Summary',
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRow('Items Count', '${cart.itemCount} items'),
                const SizedBox(height: 8),
                _buildRow('Subtotal', '₹${cart.subtotal.toStringAsFixed(0)}'),
                const SizedBox(height: 8),
                _buildRow(
                    'Discount (5%)', '- ₹${cart.discount.toStringAsFixed(0)}',
                    color: AppTheme.errorColor),
                const SizedBox(height: 8),
                _buildRow('Delivery Charge', 'FREE',
                    color: AppTheme.successColor, isBold: true),
                const Divider(height: 20),
                _buildRow(
                  'Total Payable',
                  '₹${cart.grandTotal.toStringAsFixed(0)}',
                  isBold: true,
                  fontSize: 18,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    icon: const Icon(Icons.check_circle_outline,
                        color: Colors.white),
                    label: const Text(
                      'PLACE ORDER',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _submitOrder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      {required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value,
      {Color color = AppTheme.textPrimary,
      bool isBold = false,
      double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
