import 'package:flutter/material.dart';

import 'ServiceDetailScreen.dart';
import 'model/ServiceOption.dart';
import 'subviews/subviews.dart';

const Color _kPrimaryActionColor = Color(0xFF4A6CF7);
const Color _kPrimaryActionTextColor = Colors.white;

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<ServiceOption> _serviceBundles = const [
    ServiceOption(
      icon: Icons.kitchen_outlined,
      title: 'Home appliances',
      subtitle: 'Washers, fridges, kitchen tech',
      description:
          'Certified appliance mechanics repair washers, dryers, refrigerators, ovens, and countertop devices with original parts.',
      basePrice: 59,
      eta: 'Same-day diagnosis',
    ),
    ServiceOption(
      icon: Icons.air_outlined,
      title: 'Climate & HVAC',
      subtitle: 'Thermostats, vents, purifiers',
      description:
          'Keep the air system reliable with deep cleaning, refrigerant top-ups, and smart thermostat calibration.',
      basePrice: 79,
      eta: 'Visit within 24h',
    ),
    ServiceOption(
      icon: Icons.ev_station_outlined,
      title: 'Vehicles & charging',
      subtitle: 'EV chargers, scooters, bikes',
      description:
          'Mobile pit crew handles home chargers, e-bikes, and scooters, covering cable swaps, firmware, and diagnostics.',
      basePrice: 69,
      eta: 'Technician tonight',
    ),
  ];

  final List<_NearbyRepairer> _nearbyRepairers = const [
    _NearbyRepairer(
      name: 'FixIt Appliance Hub',
      specialty: 'Home appliances · Certified Samsung & LG',
      distance: '0.8 km away',
      rating: 4.9,
      jobs: '162 repairs this month',
      availability: 'Can arrive in 45 min',
      startingFrom: 65,
      icon: Icons.kitchen,
      categories: ['Home appliances'],
      description:
          'On-site diagnostics for washers, dryers, and refrigeration systems. Includes safety check for wiring and water seals.',
    ),
    _NearbyRepairer(
      name: 'BreezeFlow Technicians',
      specialty: 'Climate & HVAC · Mitsubishi Elite',
      distance: '1.3 km away',
      rating: 4.7,
      jobs: '98 homes serviced',
      availability: 'Next slot 3:30 PM',
      startingFrom: 79,
      icon: Icons.air,
      categories: ['Climate & HVAC'],
      description:
          'Full indoor unit cleaning, refrigerant balance, and thermostat tuning to keep temps stable and bills low.',
    ),
    _NearbyRepairer(
      name: 'ChargeLab Mobile',
      specialty: 'Vehicles & charging · EV + bike',
      distance: '2.1 km away',
      rating: 4.8,
      jobs: '73 emergency calls',
      availability: 'Technician tonight',
      startingFrom: 72,
      icon: Icons.ev_station,
      categories: ['Vehicles & charging'],
      description:
          'Handles Level 2 wallboxes, portable chargers, and smart scooters. Includes firmware flash and cable replacement.',
    ),
    _NearbyRepairer(
      name: 'Metro Multi-Care',
      specialty: 'Home + vehicles',
      distance: '2.4 km away',
      rating: 4.6,
      jobs: '210 multiservice visits',
      availability: 'Morning slots open',
      startingFrom: 59,
      icon: Icons.handyman_outlined,
      categories: ['Home appliances', 'Vehicles & charging'],
      description:
          'Two-person crew that can tackle washer leaks and charger issues in a single visit. Great for mixed-device homes.',
    ),
  ];

  int _selectedCategory = 0;

  List<_NearbyRepairer> get _visibleRepairers {
    final current = _serviceBundles[_selectedCategory].title;
    return _nearbyRepairers
        .where((repairer) => repairer.categories.contains(current))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedService = _serviceBundles[_selectedCategory];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Header(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LocationBanner(onChangeTap: () => _showSnack(context)),
                    const SizedBox(height: 20),
                    const SectionTitle('Repair categories'),
                    const SizedBox(height: 12),
                    _buildCategorySelector(),
                    const SizedBox(height: 16),
                    _ServiceHighlightCard(
                      service: selectedService,
                      onTap: () => _openServiceDetail(context, selectedService),
                    ),
                    const SizedBox(height: 28),
                    const SectionTitle('Nearby service partners'),
                    const SizedBox(height: 12),
                    _buildNearbyRepairersList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _serviceBundles.length,
        itemBuilder: (context, index) {
          final bool selected = index == _selectedCategory;
          return ChoiceChip(
            label: Text(_serviceBundles[index].title),
            selected: selected,
            onSelected: (_) => setState(() => _selectedCategory = index),
            selectedColor: const Color(0xFF4A6CF7),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _buildNearbyRepairersList(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 60;

    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 4, right: 4),
        itemCount: _visibleRepairers.length,
        itemBuilder: (context, index) {
          final repairer = _visibleRepairers[index];
          return SizedBox(
            width: cardWidth.clamp(240, 360),
            child: _NearbyRepairerCard(
              repairer: repairer,
              onTap: () => _openRepairer(context, repairer),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }

  void _openRepairer(BuildContext context, _NearbyRepairer repairer) {
    final detail = ServiceOption(
      icon: repairer.icon,
      title: repairer.name,
      subtitle: repairer.specialty,
      description: repairer.description,
      basePrice: repairer.startingFrom,
      eta: repairer.availability,
    );
    _openServiceDetail(context, detail);
  }

  void _openServiceDetail(BuildContext context, ServiceOption service) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ServiceDetailScreen(service: service)),
    );
  }

  void _showSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location picker coming soon')),
    );
  }
}

class _ServiceHighlightCard extends StatelessWidget {
  const _ServiceHighlightCard({required this.service, required this.onTap});

  final ServiceOption service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFFEFF3FF),
                child: Icon(
                  service.icon,
                  color: const Color(0xFF4A6CF7),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${service.basePrice.toStringAsFixed(0)}+',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            service.description,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    service.eta,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _kPrimaryActionColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onTap,
                child: const Text('Book repair'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NearbyRepairerCard extends StatelessWidget {
  const _NearbyRepairerCard({required this.repairer, required this.onTap});

  final _NearbyRepairer repairer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFEFF3FF),
                child: Icon(repairer.icon, color: const Color(0xFF4A6CF7)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repairer.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      repairer.specialty,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB657),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(repairer.rating.toStringAsFixed(1)),
                    ],
                  ),
                  Text(
                    repairer.distance,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(repairer.jobs, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            repairer.description,
            style: const TextStyle(color: Colors.black87, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule_outlined,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      repairer.availability,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${repairer.startingFrom.toStringAsFixed(0)}+',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _kPrimaryActionColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onTap,
                child: const Text('Select'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationBanner extends StatelessWidget {
  const _LocationBanner({required this.onChangeTap});

  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFEFF3FF),
            child: Icon(Icons.near_me_outlined, color: Color(0xFF4A6CF7)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Detect location',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text('123 Ocean Dr, Miami · Live radius 5 km'),
              ],
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _kPrimaryActionColor,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onChangeTap,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

class _NearbyRepairer {
  const _NearbyRepairer({
    required this.name,
    required this.specialty,
    required this.distance,
    required this.rating,
    required this.jobs,
    required this.availability,
    required this.startingFrom,
    required this.icon,
    required this.categories,
    required this.description,
  });

  final String name;
  final String specialty;
  final String distance;
  final double rating;
  final String jobs;
  final String availability;
  final double startingFrom;
  final IconData icon;
  final List<String> categories;
  final String description;
}
