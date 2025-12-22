import 'package:flutter/material.dart';

enum DeviceCategory { automation, security, energy }

class DeviceInfo {
  const DeviceInfo({
    required this.name,
    required this.room,
    required this.icon,
    required this.status,
    required this.powerUsage,
    required this.isOnline,
    this.category = DeviceCategory.automation,
  });

  final String name;
  final String room;
  final IconData icon;
  final String status;
  final double powerUsage; // kWh per day
  final bool isOnline;
  final DeviceCategory category;

  DeviceInfo copyWith({bool? isOnline, String? status}) {
    return DeviceInfo(
      name: name,
      room: room,
      icon: icon,
      status: status ?? this.status,
      powerUsage: powerUsage,
      isOnline: isOnline ?? this.isOnline,
      category: category,
    );
  }
}
