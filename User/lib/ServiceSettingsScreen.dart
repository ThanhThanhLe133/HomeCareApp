import 'package:flutter/material.dart';

import 'subviews/subviews.dart';

const Color _kAccentColor = Color(0xFF4A6CF7);

class ServiceSettingsScreen extends StatefulWidget {
  const ServiceSettingsScreen({super.key});

  @override
  State<ServiceSettingsScreen> createState() => _ServiceSettingsScreenState();
}

class _ServiceSettingsScreenState extends State<ServiceSettingsScreen> {
  bool _autoAssignTeams = true;
  bool _shareDiagnostics = true;
  bool _allowEmergencyCalls = true;
  bool _notifyBeforeDispatch = true;
  double _maxBudget = 150;

  final List<String> _priorityFocus = const [
    'Fast response',
    'Lowest price',
    'Certified partners',
    'Eco-friendly',
  ];

  late List<bool> _prioritySelections;

  @override
  void initState() {
    super.initState();
    _prioritySelections = List<bool>.filled(_priorityFocus.length, false);
    _prioritySelections[0] = true;
    _prioritySelections[2] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Service activity settings'),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          const SectionTitle('Automation'),
          const SizedBox(height: 10),
          _buildCard(
            children: [
              _buildSwitchTile(
                title: 'Auto-assign repair teams',
                subtitle:
                    'HomeCare will pick the best rated crew and secure the slot for you.',
                value: _autoAssignTeams,
                onChanged: (value) => setState(() => _autoAssignTeams = value),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Share diagnostics before visit',
                subtitle: 'Send logs and device health reports to technicians.',
                value: _shareDiagnostics,
                onChanged: (value) => setState(() => _shareDiagnostics = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('Budget & alerts'),
          const SizedBox(height: 10),
          _buildCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Spending cap per visit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${_maxBudget.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: _kAccentColor,
                      ),
                    ),
                    Slider(
                      value: _maxBudget,
                      min: 80,
                      max: 300,
                      divisions: 11,
                      label: '\$${_maxBudget.toStringAsFixed(0)}',
                      activeColor: _kAccentColor,
                      onChanged: (value) => setState(() => _maxBudget = value),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                title: 'Notify before dispatch',
                subtitle: 'Receive a push notification to approve the visit.',
                value: _notifyBeforeDispatch,
                onChanged: (value) =>
                    setState(() => _notifyBeforeDispatch = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('Emergency coverage'),
          const SizedBox(height: 10),
          _buildCard(
            children: [
              _buildSwitchTile(
                title: 'Allow emergency calls',
                subtitle: 'Enable premium repairers to reach out by phone.',
                value: _allowEmergencyCalls,
                onChanged: (value) =>
                    setState(() => _allowEmergencyCalls = value),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Emergency coverage number',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('+1 (415) 555-0138'),
                trailing: TextButton(
                  onPressed: () => _showSnack('Change number coming soon'),
                  child: const Text('Edit'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('Priority focus'),
          const SizedBox(height: 10),
          _buildCard(
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_priorityFocus.length, (index) {
                  final selected = _prioritySelections[index];
                  return ChoiceChip(
                    label: Text(_priorityFocus[index]),
                    selected: selected,
                    selectedColor: _kAccentColor,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (value) =>
                        setState(() => _prioritySelections[index] = value),
                  );
                }),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your top picks change how we rank service partners for you.',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showSnack('Service activity settings saved');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: _kAccentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Save preferences'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4E8F5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D1F1F1F),
            offset: Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      value: value,
      activeColor: _kAccentColor,
      onChanged: onChanged,
    );
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
