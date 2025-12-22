import 'package:flutter/material.dart';

class RoomTabs extends StatelessWidget {
  const RoomTabs({
    super.key,
    required this.selectedRoom,
    required this.onRoomSelected,
  });

  final String selectedRoom;
  final ValueChanged<String> onRoomSelected;

  static const List<_Room> _rooms = [
    _Room('all', 'All Rooms (37)'),
    _Room('Living Room', 'Living Room (8)'),
    _Room('Bedroom', 'Bedroom'),
    _Room('Garage', 'Garage'),
    _Room('Studio', 'Studio'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _rooms.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final room = _rooms[index];
          final isSelected = selectedRoom == room.value;
          return _RoomChip(
            label: room.label,
            selected: isSelected,
            onTap: () => onRoomSelected(room.value),
          );
        },
      ),
    );
  }
}

class _RoomChip extends StatelessWidget {
  const _RoomChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? const Color(0xFF4A6CF7) : Colors.white,
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class _Room {
  final String value;
  final String label;
  const _Room(this.value, this.label);
}
