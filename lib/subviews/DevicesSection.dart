import 'package:flutter/material.dart';

class DevicesSection extends StatelessWidget {
  const DevicesSection({super.key, required this.devices, this.onDeviceTap});

  final List<DeviceUsage> devices;
  final void Function(DeviceUsage device, int index)? onDeviceTap;

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Devices",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return _DeviceUsageCard(
                device: device,
                onTap: onDeviceTap == null
                    ? null
                    : () => onDeviceTap!(device, index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DeviceUsageCard extends StatelessWidget {
  const _DeviceUsageCard({required this.device, this.onTap});

  final DeviceUsage device;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(device.icon, size: 28, color: device.accentColor),
              const SizedBox(height: 12),
              Text(
                "${device.kwh} kWh",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(device.price, style: const TextStyle(color: Colors.black54)),
              const Spacer(),
              Row(
                children: [
                  Text(
                    device.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right, color: device.accentColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceUsage {
  const DeviceUsage({
    required this.icon,
    required this.title,
    required this.kwh,
    required this.price,
    required this.accentColor,
  });

  final IconData icon;
  final String title;
  final String kwh;
  final String price;
  final Color accentColor;
}
