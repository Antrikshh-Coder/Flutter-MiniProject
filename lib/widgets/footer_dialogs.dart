import 'package:flutter/material.dart';

class FooterDialogs {
  static void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.support_agent_rounded, color: Color(0xFF4F46E5)),
            SizedBox(width: 10),
            Text('Contact Us'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ShopEase Customer Support Team',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('📧 Email: support@shopease.demo'),
            SizedBox(height: 4),
            Text('📞 Phone: +91 98765 43210'),
            SizedBox(height: 4),
            Text('🕒 Support Hours: Mon - Sat (9:00 AM - 7:00 PM)'),
            SizedBox(height: 12),
            Text(
              'Have questions about your order or shipping? We are here to help!',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.help_center_rounded, color: Color(0xFF4F46E5)),
            SizedBox(width: 10),
            Text('Help Center & FAQs'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Q: How can I track my order?',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Enter your Order ID on the Order Summary page.'),
            SizedBox(height: 10),
            Text('Q: What payment options are supported?',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Cash on Delivery, UPI (GPay, PhonePe), and Credit/Debit Cards.'),
            SizedBox(height: 10),
            Text('Q: How long does delivery take?',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Standard shipping takes 3-5 business days.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  static void showShippingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.local_shipping_rounded, color: Color(0xFF4F46E5)),
            SizedBox(width: 10),
            Text('Shipping & Delivery Policy'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('• Free Shipping on all orders nationwide.'),
            SizedBox(height: 6),
            Text('• Delivery Timeline: 3 to 5 Business Days.'),
            SizedBox(height: 6),
            Text('• Instant order confirmation & real-time dispatch alerts.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.info_outline_rounded, color: Color(0xFF4F46E5)),
            SizedBox(width: 10),
            Text('About ShopEase'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ShopEase – Shop Smart. Live Better.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Built as a University 20-Mark Flutter Mini Project demonstrating modern e-commerce UI design, state management, form validation, and responsive web browser layouts.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text(
          'ShopEase values user privacy. All data entered during checkout is processed locally in memory for demonstration purposes and is never transmitted to external servers.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const Text(
          'By using ShopEase, you agree to the demo terms. Products and orders generated are local university mini project demonstrations.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
