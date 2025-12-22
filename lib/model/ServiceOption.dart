import 'package:flutter/material.dart';

class ServiceOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final double basePrice;
  final String eta;

  const ServiceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.basePrice,
    required this.eta,
  });
}
