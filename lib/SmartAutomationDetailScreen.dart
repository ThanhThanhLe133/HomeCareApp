import 'package:flutter/material.dart';

import 'model/AutomationRoutine.dart';

const Color _kControlActiveColor = Color(0xFF4A6CF7);
const Color _kPrimaryActionTextColor = Colors.white;

class SmartAutomationDetailScreen extends StatefulWidget {
  const SmartAutomationDetailScreen({super.key, required this.routine});

  final AutomationRoutine routine;

  @override
  State<SmartAutomationDetailScreen> createState() =>
      _SmartAutomationDetailScreenState();
}

class _SmartAutomationDetailScreenState
    extends State<SmartAutomationDetailScreen> {
  late bool isEnabled;
  late List<bool> triggerSelections;
  late List<bool> actionSelections;
  late List<bool> daySelections;
  double startHour = 18; // 6PM default

  final List<String> _weekDays = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    super.initState();
    isEnabled = widget.routine.enabled;
    triggerSelections = List<bool>.filled(widget.routine.triggers.length, true);
    actionSelections = List<bool>.filled(widget.routine.actions.length, true);
    daySelections = List<bool>.filled(_weekDays.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(widget.routine.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SummaryCard(
            routine: widget.routine,
            isEnabled: isEnabled,
            onToggle: (value) => setState(() => isEnabled = value),
          ),
          const SizedBox(height: 18),
          _buildSectionTitle('Active days'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_weekDays.length, (index) {
              final selected = daySelections[index];
              return ChoiceChip(
                label: Text(_weekDays[index]),
                selected: selected,
                selectedColor: _kControlActiveColor,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                onSelected: (value) =>
                    setState(() => daySelections[index] = value),
              );
            }),
          ),
          const SizedBox(height: 18),
          _buildSectionTitle('Start time'),
          Slider(
            value: startHour,
            activeColor: _kControlActiveColor,
            min: 0,
            max: 23,
            divisions: 23,
            label: _formatHour(startHour),
            onChanged: (value) => setState(() => startHour = value),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Runs at ${_formatHour(startHour)}',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 18),
          _buildSectionTitle('Triggers'),
          ...List.generate(widget.routine.triggers.length, (index) {
            return SwitchListTile(
              value: triggerSelections[index],
              onChanged: (value) =>
                  setState(() => triggerSelections[index] = value),
              title: Text(widget.routine.triggers[index]),
              subtitle: const Text('Tap to include as part of this routine'),
              activeThumbColor: _kControlActiveColor,
            );
          }),
          const SizedBox(height: 8),
          _buildSectionTitle('Actions'),
          ...List.generate(widget.routine.actions.length, (index) {
            return CheckboxListTile(
              value: actionSelections[index],
              onChanged: (value) =>
                  setState(() => actionSelections[index] = value ?? true),
              title: Text(widget.routine.actions[index]),
              activeColor: _kControlActiveColor,
              checkColor: Colors.white,
            );
          }),
          const SizedBox(height: 12),
          _buildSectionTitle('Devices involved'),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.routine.devices
                .map(
                  (device) => SizedBox(
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () => _showDeviceQuickActions(device),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        side: const BorderSide(color: _kControlActiveColor),
                        foregroundColor: _kControlActiveColor,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.memory, size: 18),
                      label: Text(
                        device,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: widget.routine.tags
                .map(
                  (tag) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Color(0xFF4A6CF7)),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: _kControlActiveColor,
                foregroundColor: _kPrimaryActionTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _saveAutomation,
              child: const Text('Save automation'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _runAutomationNow,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: _kControlActiveColor),
                foregroundColor: _kControlActiveColor,
              ),
              child: const Text('Run now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    );
  }

  String _formatHour(double hour) {
    final intHour = hour.round();
    final suffix = intHour >= 12 ? 'PM' : 'AM';
    final displayHour = intHour % 12 == 0 ? 12 : intHour % 12;
    return '${displayHour.toString().padLeft(2, '0')}:00 $suffix';
  }

  void _saveAutomation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Automation preferences saved.')),
    );
  }

  void _runAutomationNow() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Run now?'),
          content: const Text('Selected actions will execute immediately.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Automation triggered.')),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showDeviceQuickActions(String device) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.memory,
                      color: _kControlActiveColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      device,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose how this device participates in the routine.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: _kControlActiveColor,
                    foregroundColor: _kPrimaryActionTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$device temporarily disabled.')),
                    );
                  },
                  child: const Text('Temporarily disable'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Replace $device with another device.'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: _kControlActiveColor),
                    foregroundColor: _kControlActiveColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Replace device'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.routine,
    required this.isEnabled,
    required this.onToggle,
  });

  final AutomationRoutine routine;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  routine.icons.first,
                  color: const Color(0xFF4A6CF7),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routine.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      routine.description,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isEnabled,
                activeThumbColor: _kControlActiveColor,
                onChanged: onToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
