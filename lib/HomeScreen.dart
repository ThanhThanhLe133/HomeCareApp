import 'package:flutter/material.dart';

import 'AddDeviceScreen.dart';
import 'ChatBotScreen.dart';
import 'NotificationScreen.dart';
import 'model/DeviceInfo.dart';
import 'subviews/subviews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DeviceInfo> _devices;
  String _selectedRoom = 'all';
  DeviceCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _devices = [
      const DeviceInfo(
        name: 'Smart Lamp',
        room: 'Living Room',
        icon: Icons.lightbulb_outline,
        status: 'Warm white · 65%',
        powerUsage: 12,
        isOnline: true,
        category: DeviceCategory.automation,
      ),
      const DeviceInfo(
        name: 'Security Camera',
        room: 'Garage',
        icon: Icons.videocam_outlined,
        status: 'Streaming 1080p',
        powerUsage: 8,
        isOnline: true,
        category: DeviceCategory.security,
      ),
      const DeviceInfo(
        name: 'Air Purifier',
        room: 'Bedroom',
        icon: Icons.air_outlined,
        status: 'Filter 92% health',
        powerUsage: 20,
        isOnline: true,
        category: DeviceCategory.energy,
      ),
      const DeviceInfo(
        name: 'Decor Lamp',
        room: 'Studio',
        icon: Icons.brush_outlined,
        status: 'Sunset palette',
        powerUsage: 9,
        isOnline: false,
        category: DeviceCategory.automation,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final visibleDevices = _devices.where((device) {
      final matchesRoom =
          _selectedRoom == 'all' || device.room == _selectedRoom;
      final matchesCategory =
          _selectedCategory == null || device.category == _selectedCategory;
      return matchesRoom && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                onNotificationTap: () => _openNotifications(context),
                onChatTap: () => _openChatBot(context),
              ),
              const SizedBox(height: 16),
              const WeatherCard(),
              const SizedBox(height: 20),
              CategoryRow(
                onCategoryTap: _handleCategoryTap,
                selectedLabel: _selectedCategory != null
                    ? _labelForCategory(_selectedCategory!)
                    : null,
              ),
              const SizedBox(height: 16),
              RoomTabs(
                selectedRoom: _selectedRoom,
                onRoomSelected: _handleRoomSelected,
              ),
              const SizedBox(height: 16),
              const Text(
                'All Devices',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DeviceGrid(
                devices: visibleDevices,
                onDeviceTap: _showDeviceDetail,
                onToggle: _handleToggle,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _openNotifications(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const NotificationScreen()));
  }

  void _openChatBot(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ChatBotScreen()));
  }

  void _handleToggle(DeviceInfo device, bool value) {
    setState(() {
      final index = _devices.indexWhere((d) => d.name == device.name);
      if (index == -1) return;
      _devices[index] = _devices[index].copyWith(
        isOnline: value,
        status: value ? 'Running since 18:20' : 'Offline · saving energy',
      );
    });
  }

  void _handleCategoryTap(String label) {
    if (label == 'Add Device') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AddDeviceScreen()));
      return;
    }

    final category = _categoryForLabel(label);
    if (category == null) return;
    setState(() {
      _selectedCategory = _selectedCategory == category ? null : category;
    });
  }

  DeviceCategory? _categoryForLabel(String label) {
    switch (label) {
      case 'Automation':
        return DeviceCategory.automation;
      case 'Security':
        return DeviceCategory.security;
      case 'Energy':
        return DeviceCategory.energy;
      default:
        return null;
    }
  }

  String _labelForCategory(DeviceCategory category) {
    switch (category) {
      case DeviceCategory.automation:
        return 'Automation';
      case DeviceCategory.security:
        return 'Security';
      case DeviceCategory.energy:
        return 'Energy';
    }
  }

  void _handleRoomSelected(String value) {
    setState(() => _selectedRoom = value);
  }

  void _showDeviceDetail(DeviceInfo device) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeviceDetailSheet(
        device: device,
        onToggle: (value) => _handleToggle(device, value),
        onSchedule: () => _openSchedule(device),
        onRoutine: () => _openRoutineDialog(device),
      ),
    );
  }

  void _openSchedule(DeviceInfo device) {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeviceScheduleSheet(device: device),
    );
  }

  void _openRoutineDialog(DeviceInfo device) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add to automation'),
        content: Text('Link ${device.name} to wake-up or away routines?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${device.name} added to Sunrise Routine'),
                ),
              );
            },
            child: const Text('Add now'),
          ),
        ],
      ),
    );
  }
}

class DeviceDetailSheet extends StatefulWidget {
  const DeviceDetailSheet({
    super.key,
    required this.device,
    required this.onToggle,
    required this.onSchedule,
    required this.onRoutine,
  });

  final DeviceInfo device;
  final ValueChanged<bool> onToggle;
  final VoidCallback onSchedule;
  final VoidCallback onRoutine;

  @override
  State<DeviceDetailSheet> createState() => _DeviceDetailSheetState();
}

class _DeviceDetailSheetState extends State<DeviceDetailSheet> {
  double _intensity = 0.6;
  String _scene = 'Focus';

  @override
  Widget build(BuildContext context) {
    final device = widget.device;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                width: 46,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3FF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    device.icon,
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
                        device.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.room,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        device.status,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: device.isOnline,
                  activeThumbColor: const Color(0xFF4A6CF7),
                  onChanged: widget.onToggle,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Intensity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: _intensity,
                    onChanged: (value) => setState(() => _intensity = value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Calm'), Text('Bright')],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Scenes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ['Focus', 'Relax', 'Sunset', 'Movie']
                  .map(
                    (label) => ChoiceChip(
                      label: Text(label),
                      selected: _scene == label,
                      onSelected: (_) => setState(() => _scene = label),
                      selectedColor: const Color(0xFF4A6CF7),
                      labelStyle: TextStyle(
                        color: _scene == label ? Colors.white : Colors.black87,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Device actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              title: 'Schedule & timers',
              subtitle: 'Run at sunrise or before you get home',
              icon: Icons.schedule,
              onTap: widget.onSchedule,
            ),
            _ActionTile(
              title: 'Automation & routines',
              subtitle: 'Blend into Smart tab workflows',
              icon: Icons.auto_mode_outlined,
              onTap: widget.onRoutine,
            ),
            _ActionTile(
              title: 'Energy report',
              subtitle: 'Last 24h · ${device.powerUsage} kWh',
              icon: Icons.bolt_outlined,
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Energy insights generated')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceScheduleSheet extends StatefulWidget {
  const DeviceScheduleSheet({super.key, required this.device});

  final DeviceInfo device;

  @override
  State<DeviceScheduleSheet> createState() => _DeviceScheduleSheetState();
}

class _DeviceScheduleSheetState extends State<DeviceScheduleSheet> {
  TimeOfDay _time = const TimeOfDay(hour: 6, minute: 30);
  bool _weekdaysOnly = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.8,
      minChildSize: 0.4,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                width: 46,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Text(
              'Schedule ${widget.device.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.device.room,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Trigger time'),
              subtitle: Text(_time.format(context)),
              trailing: const Icon(Icons.timer_outlined),
              onTap: _pickTime,
            ),
            const Divider(height: 32),
            SwitchListTile.adaptive(
              value: _weekdaysOnly,
              onChanged: (value) => setState(() => _weekdaysOnly = value),
              title: const Text('Weekdays only'),
              subtitle: const Text('Pause routine on weekends'),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${widget.device.name} scheduled for ${_time.format(context)} ${_weekdaysOnly ? 'on weekdays' : 'daily'}',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Save schedule'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() => _time = picked);
    }
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F5FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: const Color(0xFF4A6CF7)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
