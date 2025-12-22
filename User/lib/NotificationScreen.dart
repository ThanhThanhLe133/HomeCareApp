import 'package:flutter/material.dart';

import 'subviews/SegmentTabsNotification.dart';
import 'subviews/subviews.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 1; // 0 = Service, 1 = Smart Home

  static const List<_NotificationGroup> _serviceNotifications = [
    _NotificationGroup(
      title: 'Today',
      items: [
        _NotificationEntry(
          icon: Icons.handyman_outlined,
          title: 'Technician en route',
          content:
              'Your appliance repair partner FixIt Appliance Hub will arrive in 25 minutes. Track them in Services.',
          time: '10:05 AM',
          isAlert: true,
        ),
        _NotificationEntry(
          icon: Icons.description_outlined,
          title: 'Visit summary ready',
          content:
              'Your HVAC maintenance report from BreezeFlow Technicians is available. Tap to review work performed.',
          time: '08:46 AM',
        ),
      ],
    ),
    _NotificationGroup(
      title: 'Yesterday',
      items: [
        _NotificationEntry(
          icon: Icons.event_available_outlined,
          title: 'New service window',
          content:
              'ChargeLab Mobile opened an evening slot for EV charger calibration tomorrow.',
          time: '06:30 PM',
        ),
        _NotificationEntry(
          icon: Icons.check_circle_outline,
          title: 'Cleaning completed',
          content:
              'Metro Multi-Care finished your combined washer + charger visit. Rate the experience to unlock loyalty perks.',
          time: '02:18 PM',
        ),
      ],
    ),
  ];

  static const List<_NotificationGroup> _smartNotifications = [
    _NotificationGroup(
      title: 'Today',
      items: [
        _NotificationEntry(
          icon: Icons.lock_outline,
          title: 'Front door locked',
          content:
              'Go to Office automation secured the entrance at 08:12 AM as scheduled.',
          time: '08:12 AM',
          isAlert: true,
        ),
        _NotificationEntry(
          icon: Icons.thermostat_outlined,
          title: 'Energy saver running',
          content:
              'Thermostat dropped to 20°C and standby plugs turned off after Travel Mode triggered.',
          time: '07:55 AM',
        ),
      ],
    ),
    _NotificationGroup(
      title: 'Yesterday',
      items: [
        _NotificationEntry(
          icon: Icons.lightbulb_outline,
          title: 'Lights left on',
          content:
              'Tap-to-run shortcut “Movie night” kept the living room lights at 40% for 3 hours.',
          time: '11:04 PM',
        ),
        _NotificationEntry(
          icon: Icons.bolt,
          title: 'Usage spike detected',
          content:
              'Bedroom heater exceeded typical energy budget. Consider enabling eco preset.',
          time: '05:10 PM',
        ),
        _NotificationEntry(
          icon: Icons.sensors,
          title: 'Sensor battery low',
          content: 'Window contact sensor in Study is below 10%. Replace soon.',
          time: '04:22 PM',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 12),
            _SegmentTabs(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _buildNotificationGroups(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 12),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _SegmentTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SegmentTabsNotification(
        selectedIndex: selectedTab,
        onChanged: (index) => setState(() => selectedTab = index),
      ),
    );
  }

  List<Widget> _buildNotificationGroups() {
    final groups = selectedTab == 0
        ? _serviceNotifications
        : _smartNotifications;
    return [
      for (final group in groups) ...[
        SectionTitle(group.title),
        const SizedBox(height: 8),
        for (final entry in group.items)
          NotificationItem(
            icon: entry.icon,
            title: entry.title,
            content: entry.content,
            time: entry.time,
            isAlert: entry.isAlert,
          ),
        const SizedBox(height: 16),
      ],
    ];
  }
}

class _NotificationGroup {
  const _NotificationGroup({required this.title, required this.items});

  final String title;
  final List<_NotificationEntry> items;
}

class _NotificationEntry {
  const _NotificationEntry({
    required this.icon,
    required this.title,
    required this.content,
    required this.time,
    this.isAlert = false,
  });

  final IconData icon;
  final String title;
  final String content;
  final String time;
  final bool isAlert;
}
