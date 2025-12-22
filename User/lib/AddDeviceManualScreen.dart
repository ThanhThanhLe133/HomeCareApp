import 'package:flutter/material.dart';

class AddDeviceManualScreen extends StatefulWidget {
  const AddDeviceManualScreen({super.key});

  @override
  State<AddDeviceManualScreen> createState() => _AddDeviceManualScreenState();
}

class _AddDeviceManualScreenState extends State<AddDeviceManualScreen> {
  int selectedTab = 1; // 0 = Nearby, 1 = Add Manual
  int selectedCategory = 0;

  final List<String> categories = const [
    "Popular",
    "Lighting",
    "Camera",
    "Energy",
  ];

  final List<DeviceItem> devices = const [
    DeviceItem("Smart CCTV", "assets/cctv.png"),
    DeviceItem("Smart Webcam", "assets/webcam.png"),
    DeviceItem("Smart V2 CCTV", "assets/cctv2.png"),
    DeviceItem("Smart Lamp", "assets/lamp.png"),
    DeviceItem("Smart Speaker", "assets/speaker.png"),
    DeviceItem("Smart Router", "assets/router.png"),
  ];

  void _handleTabTap(int index) {
    if (index == selectedTab) return;
    if (index == 0 && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 12),
            _SegmentTabs(),
            const SizedBox(height: 16),
            _CategoryChips(),
            const SizedBox(height: 16),
            Expanded(child: _DeviceGrid()),
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
            'Add Device Manually',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _SegmentTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
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
            _TabButton(title: 'Nearby Devices', index: 0),
            _TabButton(title: 'Add Manual', index: 1),
          ],
        ),
      ),
    );
  }

  Widget _TabButton({required String title, required int index}) {
    final bool selected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTabTap(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF4A6CF7) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
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

  Widget _CategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final bool selected = selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF4A6CF7) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF4A6CF7)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _DeviceGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    device.asset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.devices_other,
                      size: 48,
                      color: Color(0xFF4A6CF7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                device.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Living Room',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeviceItem {
  final String name;
  final String asset;

  const DeviceItem(this.name, this.asset);
}
