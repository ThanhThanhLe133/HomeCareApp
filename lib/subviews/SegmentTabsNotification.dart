import 'package:flutter/material.dart';

import 'SegmentTabs.dart';

class SegmentTabsNotification extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentTabsNotification({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentTabs(
      tabs: const ['Service', 'Smart Home'],
      selectedIndex: selectedIndex,
      onChanged: onChanged,
    );
  }
}
