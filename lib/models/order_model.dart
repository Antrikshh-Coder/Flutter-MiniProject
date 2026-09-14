import 'cart_item.dart';

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final String customerName;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String pinCode;
  final String paymentMethod;
  final double subtotal;
  final double discount;
  final double totalAmount;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.customerName,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.pinCode,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.totalAmount,
    required this.orderDate,
  });
}
