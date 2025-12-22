import 'package:flutter/material.dart';

import 'model/ServiceOption.dart';

const Color _kPrimaryActionColor = Color(0xFF4A6CF7);
const Color _kPrimaryActionTextColor = Colors.white;

const String _currencySymbol = '\$';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key, required this.service});

  final ServiceOption service;

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final List<String> _dateOptions = const [
    'Today',
    'Tomorrow',
    'Later this week',
  ];
  final List<String> _timeOptions = const [
    '09:00 AM',
    '11:30 AM',
    '02:00 PM',
    '05:30 PM',
  ];
  final List<_PlanOption> _planOptions = const [
    _PlanOption('Remote Assist', 'Video diagnosis & guided fix', 0),
    _PlanOption('Priority Visit', 'Tech visits within 6 hours', 29),
    _PlanOption('Premium Care', '1-hour response + spare parts', 59),
  ];

  int _selectedDate = 0;
  int _selectedTime = 1;
  int _selectedPlan = 1;

  double get _planFee => _planOptions[_selectedPlan].fee;
  double get _subtotal => widget.service.basePrice + _planFee;
  double get _serviceFee => 9;
  double get _total => _subtotal + _serviceFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(widget.service.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ServiceHeroCard(service: widget.service),
          const SizedBox(height: 20),
          _buildSectionTitle('Preferred date'),
          _buildChipSelector(
            options: _dateOptions,
            selectedIndex: _selectedDate,
            onSelected: (index) => setState(() => _selectedDate = index),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Time window'),
          _buildChipSelector(
            options: _timeOptions,
            selectedIndex: _selectedTime,
            onSelected: (index) => setState(() => _selectedTime = index),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Service plan'),
          ...List.generate(
            _planOptions.length,
            (index) => _PlanTile(
              option: _planOptions[index],
              selected: _selectedPlan == index,
              onTap: () => setState(() => _selectedPlan = index),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Order summary'),
          _SummaryRow(label: 'Base service', value: widget.service.basePrice),
          _SummaryRow(label: _planOptions[_selectedPlan].name, value: _planFee),
          _SummaryRow(label: 'Service fee', value: _serviceFee),
          const Divider(height: 32),
          _SummaryRow(label: 'Total due', value: _total, emphasize: true),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: _kPrimaryActionColor,
                foregroundColor: _kPrimaryActionTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _openPaymentSheet,
              child: const Text('Book & Pay'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildChipSelector({
    required List<String> options,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
  }) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final bool selected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF4A6CF7) : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF4A6CF7)
                      : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                options[index],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: options.length,
      ),
    );
  }

  void _openPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (sheetContext) {
        int methodIndex = 0;
        final methods = [
          _PaymentMethod('Visa •••• 2256', Icons.credit_card, 'Expires 03/28'),
          _PaymentMethod('Apple Pay', Icons.phone_iphone, 'Thanh toán tức thì'),
          _PaymentMethod(
            'PayPal',
            Icons.account_balance_wallet_outlined,
            'pay@homecare.com',
          ),
        ];

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 48,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const Text(
                      'Select payment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Total $_currencySymbol${_total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      methods.length,
                      (index) => RadioListTile<int>(
                        value: index,
                        groupValue: methodIndex,
                        onChanged: (value) =>
                            setModalState(() => methodIndex = value!),
                        title: Text(methods[index].label),
                        subtitle: Text(methods[index].description),
                        secondary: Icon(
                          methods[index].icon,
                          color: const Color(0xFF4A6CF7),
                        ),
                        activeColor: _kPrimaryActionColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: _kPrimaryActionColor,
                          foregroundColor: _kPrimaryActionTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(sheetContext).pop();
                          _showSuccessDialog(methods[methodIndex].label);
                        },
                        child: const Text('Confirm & Pay'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(String method) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Booking confirmed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment method: $method'),
              const SizedBox(height: 8),
              Text(
                'Appointment: ${_dateOptions[_selectedDate]} at ${_timeOptions[_selectedTime]}',
              ),
              const SizedBox(height: 8),
              Text('Total paid: $_currencySymbol${_total.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}

class _ServiceHeroCard extends StatelessWidget {
  const _ServiceHeroCard({required this.service});

  final ServiceOption service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  service.icon,
                  color: const Color(0xFF4A6CF7),
                  size: 34,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            service.description,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    service.eta,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              Text(
                '$_currencySymbol${service.basePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _PlanOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xFF4A6CF7) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  option.fee == 0
                      ? 'Included'
                      : '+$_currencySymbol${option.fee.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? const Color(0xFF4A6CF7) : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanOption {
  final String name;
  final String description;
  final double fee;

  const _PlanOption(this.name, this.description, this.fee);
}

class _PaymentMethod {
  final String label;
  final IconData icon;
  final String description;

  const _PaymentMethod(this.label, this.icon, this.description);
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: emphasize ? 18 : 16,
      fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text('$_currencySymbol${value.toStringAsFixed(2)}', style: textStyle),
        ],
      ),
    );
  }
}
