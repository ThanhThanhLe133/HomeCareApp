import 'package:flutter/material.dart';

import '../model/DeviceInfo.dart';

class DeviceGrid extends StatelessWidget {
  const DeviceGrid({
    super.key,
    required this.devices,
    required this.onDeviceTap,
    required this.onToggle,
  });

  final List<DeviceInfo> devices;
  final ValueChanged<DeviceInfo> onDeviceTap;
  final void Function(DeviceInfo device, bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return _DeviceCard(
          device: device,
          onTap: () => onDeviceTap(device),
          onToggle: (value) => onToggle(device, value),
        );
      },
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.onTap,
    required this.onToggle,
  });

  final DeviceInfo device;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(device.icon, color: const Color(0xFF4A6CF7)),
                ),
                Switch(
                  value: device.isOnline,
                  activeThumbColor: const Color(0xFF4A6CF7),
                  onChanged: onToggle,
                ),
              ],
            ),
            const Spacer(),
            Text(
              device.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(device.room, style: const TextStyle(color: Colors.black54)),
            Text(
              device.status,
              style: const TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
