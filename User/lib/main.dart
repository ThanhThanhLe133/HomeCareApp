import 'package:flutter/material.dart';

import 'AccountScreen.dart';
import 'AddDeviceManualScreen.dart';
import 'AddDeviceScreen.dart';
import 'BottomNav.dart';
import 'HomeScreen.dart';
import 'ReportsScreen.dart';
import 'ServicesScreen.dart';
import 'SmartScreen.dart';

void main() {
  runApp(const HomeCareApp());
}

class HomeCareApp extends StatelessWidget {
  const HomeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A6CF7),
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const _RootShell(),
    );
  }
}

class _RootShell extends StatefulWidget {
  const _RootShell();

  @override
  State<_RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<_RootShell> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    SmartScreen(),
    ServicesScreen(),
    ReportsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              heroTag: 'home-add-device-fab',
              backgroundColor: const Color(0xFF4A6CF7),
              shape: const CircleBorder(),
              onPressed: _openAddDeviceSheet,
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            )
          : null,
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  void _openAddDeviceSheet() {
    final rootContext = context;
    showModalBottomSheet(
      context: rootContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return _AddDeviceOptions(
          onScan: () {
            Navigator.of(sheetContext).pop();
            Navigator.of(
              rootContext,
            ).push(MaterialPageRoute(builder: (_) => const AddDeviceScreen()));
          },
          onManual: () {
            Navigator.of(sheetContext).pop();
            Navigator.of(rootContext).push(
              MaterialPageRoute(builder: (_) => const AddDeviceManualScreen()),
            );
          },
        );
      },
    );
  }
}

class _AddDeviceOptions extends StatelessWidget {
  const _AddDeviceOptions({required this.onScan, required this.onManual});

  final VoidCallback onScan;
  final VoidCallback onManual;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
              'Add new device',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose how you want to connect a device to your home.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            _OptionTile(
              icon: Icons.wifi_tethering,
              iconColor: const Color(0xFF4A6CF7),
              title: 'Scan nearby devices',
              subtitle: 'Automatically discover supported devices around you.',
              onTap: onScan,
            ),
            const SizedBox(height: 12),
            _OptionTile(
              icon: Icons.add_box_outlined,
              iconColor: const Color(0xFF22B07D),
              title: 'Add manually',
              subtitle: 'Enter the device credentials or select from catalog.',
              onTap: onManual,
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
