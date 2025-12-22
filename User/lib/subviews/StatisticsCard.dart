import 'dart:math' as math;

import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.timeframeLabel,
    required this.values,
    required this.labels,
  });

  final String timeframeLabel;
  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    assert(
      values.length == labels.length,
      'values and labels should align for the chart',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Statistics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  timeframeLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
            const SizedBox(height: 20),
            _BarChart(values: values, labels: labels),
          ],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.values, required this.labels});

  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxValue = values.reduce(math.max);
    final barColor = const Color(0xFF4A6CF7);

    return SizedBox(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(values.length, (i) {
          final normalizedHeight = maxValue == 0
              ? 20.0
              : ((values[i] / maxValue) * 140) + 20;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 26,
                height: normalizedHeight,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 8),
              Text(labels[i], style: const TextStyle(color: Colors.black54)),
            ],
          );
        }),
      ),
    );
  }
}
