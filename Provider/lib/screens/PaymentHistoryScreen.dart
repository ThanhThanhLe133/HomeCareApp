import 'package:flutter/material.dart';
import '../widgets/CustomStatusBar.dart';

class PaymentRecord {
  final String name;
  final String ticketId;
  final String id;
  final String status;
  final String method;
  final String amount;

  PaymentRecord({
    required this.name,
    required this.ticketId,
    required this.id,
    required this.status,
    required this.method,
    required this.amount,
  });
}

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data based on the screenshot
    final List<PaymentRecord> payments = [
      PaymentRecord(
        name: 'Huu Nghia',
        ticketId: '#123',
        id: '#12',
        status: 'Pending',
        method: 'Cash',
        amount: 'VND 120,000',
      ),
      PaymentRecord(
        name: 'Suong Suong',
        ticketId: '#124',
        id: '#14',
        status: 'Pending',
        method: 'wallet',
        amount: 'VND 990,000',
      ),
      PaymentRecord(
        name: 'Thanh Thanh',
        ticketId: '#125',
        id: '#12',
        status: 'Pending',
        method: 'Wallet',
        amount: 'VND 120,000',
      ),
    ];

    return Column(
      children: [
        const CustomStatusBar(backgroundColor: Color(0xFFF8F9FD)),
        Expanded(
          child: Scaffold(
            backgroundColor: const Color(0xFFF8F9FD),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Payment',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: payments.length,
              itemBuilder: (context, index) {
                return _buildPaymentCard(payments[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  // 1. Payment Card Widget
  Widget _buildPaymentCard(PaymentRecord payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F4FA),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  payment.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  payment.ticketId,
                  style: const TextStyle(
                    color: Color(0xFF4361EE),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Details Rows
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDataRow('ID', payment.id),
                const Divider(),
                _buildDataRow('Status', payment.status),
                const Divider(),
                _buildDataRow('Method', payment.method),
                const Divider(),
                _buildDataRow('Amount Paid', payment.amount, isAmount: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Data Row Helper
  Widget _buildDataRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.normal,
              color: isAmount ? const Color(0xFF4361EE) : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
