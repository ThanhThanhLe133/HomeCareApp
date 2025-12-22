import 'package:flutter/material.dart';

class AutomationRoutine {
  final String title;
  final String description;
  final List<String> triggers;
  final List<String> actions;
  final List<String> devices;
  final List<String> tags;
  final List<IconData> icons;
  final bool enabled;

  const AutomationRoutine({
    required this.title,
    required this.description,
    required this.triggers,
    required this.actions,
    required this.devices,
    required this.tags,
    required this.icons,
    this.enabled = true,
  });
}
