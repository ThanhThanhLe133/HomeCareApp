import 'package:flutter/material.dart';

import 'SmartAutomationDetailScreen.dart';
import 'model/AutomationRoutine.dart';
import 'subviews/subviews.dart';

const Color _kPrimaryActionColor = Color(0xFF4A6CF7);
const Color _kPrimaryTextColor = Colors.white;

class SmartScreen extends StatefulWidget {
  const SmartScreen({super.key});

  @override
  State<SmartScreen> createState() => _SmartScreenState();
}

class _SmartScreenState extends State<SmartScreen> {
  int selectedTab = 0; // 0 = Automation, 1 = Tap To Run

  static const List<AutomationRoutine> _routines = [
    AutomationRoutine(
      title: 'Turn on the AC',
      description: 'Keeps the living room cool before you arrive.',
      triggers: ['Arrive home', 'Temperature > 30°C'],
      actions: ['Turn on AC', 'Set temperature to 24°C', 'Enable dehumidifier'],
      devices: ['Living Room AC', 'Climate Sensor'],
      tags: ['Comfort', 'Energy'],
      icons: [Icons.thermostat, Icons.water_drop, Icons.ac_unit],
      enabled: true,
    ),
    AutomationRoutine(
      title: 'Turn ON All the Lights',
      description: 'Brightens every room when you arrive home late.',
      triggers: ['Arrive after 7 PM', 'Motion detected'],
      actions: ['Turn on hallway lights', 'Turn on bedroom lights'],
      devices: ['Hallway Lamp', 'Bedroom Strip'],
      tags: ['Safety'],
      icons: [Icons.schedule, Icons.wb_sunny],
      enabled: true,
    ),
    AutomationRoutine(
      title: 'Go to Office',
      description: 'Prepares the house when you leave every morning.',
      triggers: ['Weekdays 8 AM'],
      actions: [
        'Turn off living room lights',
        'Enable security cameras',
        'Lock main door',
      ],
      devices: ['Front Door Lock', 'Security Hub'],
      tags: ['Security', 'Routine'],
      icons: [Icons.location_on, Icons.schedule, Icons.alarm, Icons.sell],
      enabled: true,
    ),
    AutomationRoutine(
      title: 'Energy Saver Mode',
      description: 'Aggressively cuts standby power when you travel.',
      triggers: ['Travel mode', 'No presence detected'],
      actions: ['Turn off plugs', 'Lower thermostat to 20°C'],
      devices: ['Smart Plug Pack', 'Thermostat'],
      tags: ['Energy'],
      icons: [Icons.work, Icons.verified_user, Icons.notifications],
      enabled: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      floatingActionButton: FloatingActionButton(
        heroTag: 'smart-screen-automation-fab',
        backgroundColor: _kPrimaryActionColor,
        shape: const CircleBorder(),
        onPressed: _openCreateAutomationSheet,
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 12),
            _SegmentTabs(),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: selectedTab == 0
                    ? _AutomationList()
                    : _TapToRunShortcuts(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header
  Widget _Header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            "My Home",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.keyboard_arrow_down),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.description_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
        ],
      ),
    );
  }

  /// Segmented Automation / Tap to Run
  Widget _SegmentTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F0A0A0A),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            _SegmentItem("Automation", 0),
            _SegmentItem("Tap To Run", 1),
          ],
        ),
      ),
    );
  }

  Widget _SegmentItem(String title, int index) {
    final selected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? _kPrimaryActionColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// List automation cards
  Widget _AutomationList() {
    return ListView.builder(
      key: const ValueKey('automation-list'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _routines.length,
      itemBuilder: (context, index) {
        final routine = _routines[index];
        return AutomationCard(
          title: routine.title,
          taskCount: routine.actions.length,
          icons: routine.icons,
          enabled: routine.enabled,
          onTap: () => _openAutomationDetail(routine),
        );
      },
    );
  }

  Widget _TapToRunShortcuts() {
    final shortcuts = const [
      _ShortcutOption('Morning boost', Icons.coffee, 'Open blinds, play news'),
      _ShortcutOption(
        'Movie night',
        Icons.movie_filter,
        'Dim lights, enable surround',
      ),
      _ShortcutOption('Clean air', Icons.air, 'Start purifier for 20 mins'),
      _ShortcutOption(
        'Water plants',
        Icons.local_florist,
        'Activate irrigation',
      ),
    ];

    return ListView.builder(
      key: const ValueKey('tap-to-run'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: shortcuts.length,
      itemBuilder: (context, index) {
        final item = shortcuts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(item.icon, color: _kPrimaryActionColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showRunConfirmation(item.title),
                icon: const Icon(
                  Icons.play_circle_outline,
                  color: _kPrimaryActionColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openAutomationDetail(AutomationRoutine routine) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SmartAutomationDetailScreen(routine: routine),
      ),
    );
  }

  void _openCreateAutomationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (sheetContext) {
        String routineName = '';
        int triggerIndex = 0;
        final triggers = ['Sunset', 'Arrive home', 'Humidity > 70%'];
        bool includeNotification = true;

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
                      'Quick automation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Routine name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setModalState(() => routineName = value),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<int>(
                      initialValue: triggerIndex,
                      decoration: const InputDecoration(
                        labelText: 'Primary trigger',
                        border: OutlineInputBorder(),
                      ),
                      items: List.generate(
                        triggers.length,
                        (index) => DropdownMenuItem(
                          value: index,
                          child: Text(triggers[index]),
                        ),
                      ),
                      onChanged: (value) =>
                          setModalState(() => triggerIndex = value ?? 0),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: includeNotification,
                      title: const Text('Send push notification'),
                      onChanged: (value) =>
                          setModalState(() => includeNotification = value),
                      activeThumbColor: _kPrimaryActionColor,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPrimaryActionColor,
                          foregroundColor: _kPrimaryTextColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: routineName.trim().isEmpty
                            ? null
                            : () {
                                Navigator.of(sheetContext).pop();
                                _showCreationToast(
                                  routineName,
                                  triggers[triggerIndex],
                                  includeNotification,
                                );
                              },
                        child: const Text('Create automation'),
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

  void _showCreationToast(String name, String trigger, bool notify) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Automation "$name" will run on "$trigger"${notify ? ' with notification' : ''}.',
        ),
      ),
    );
  }

  void _showRunConfirmation(String shortcutName) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Run shortcut?'),
          content: Text('"$shortcutName" will run immediately.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: _kPrimaryActionColor),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _kPrimaryActionColor,
                foregroundColor: _kPrimaryTextColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$shortcutName executed.')),
                );
              },
              child: const Text('Run now'),
            ),
          ],
        );
      },
    );
  }
}

class _ShortcutOption {
  const _ShortcutOption(this.title, this.icon, this.subtitle);

  final String title;
  final IconData icon;
  final String subtitle;
}
