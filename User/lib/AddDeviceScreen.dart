import 'package:flutter/material.dart';

import 'AddDeviceManualScreen.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  int selectedTab = 0; // 0 = Nearby, 1 = Manual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Add Device",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _SegmentTabs(),
            const SizedBox(height: 40),
            const Text(
              "Looking for nearby devices...",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _HintCard(),
            const SizedBox(height: 40),
            _ScanAnimation(),
            const Spacer(),
            _ConnectButton(),
            const SizedBox(height: 16),
            _LearnMore(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Tabs: Nearby Devices | Add Manual
  Widget _SegmentTabs() {
    return Container(
      height: 48,
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
        children: [_TabItem("Nearby Devices", 0), _TabItem("Add Manual", 1)],
      ),
    );
  }

  Widget _TabItem(String title, int index) {
    final bool selected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTabTap(index),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF4A6CF7) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _handleTabTap(int index) {
    if (index == selectedTab) return;
    if (index == 1) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AddDeviceManualScreen()));
      return;
    }
    setState(() => selectedTab = index);
  }

  /// Wifi & Bluetooth hint
  Widget _HintCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.wifi, color: Color(0xFF4A6CF7)),
          SizedBox(width: 8),
          Icon(Icons.bluetooth, color: Color(0xFF4A6CF7)),
          SizedBox(width: 12),
          Text(
            "Turn on your Wifi & Bluetooth to connect",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// Scan animation placeholder
  Widget _ScanAnimation() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4A6CF7), width: 6),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4A6CF7),
            ),
          ),
        ],
      ),
    );
  }

  /// Connect button
  Widget _ConnectButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A6CF7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Connect to All Devices",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Learn more
  Widget _LearnMore() {
    return Column(
      children: [
        const Text(
          "Can’t find your devices?",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Learn more",
            style: TextStyle(color: Color(0xFF4A6CF7)),
          ),
        ),
      ],
    );
  }
}
