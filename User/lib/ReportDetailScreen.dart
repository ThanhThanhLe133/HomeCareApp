import 'package:flutter/material.dart';

const Color _kReportPrimaryColor = Color(0xFF4A6CF7);
const Color _kReportPrimaryTextColor = Colors.white;

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.metrics,
    required this.insights,
    this.heroIcon,
    this.heroColor,
    this.heroStat,
    this.heroSubtext,
  });

  final String title;
  final String description;
  final List<ReportDetailItem> metrics;
  final List<String> insights;
  final IconData? heroIcon;
  final Color? heroColor;
  final String? heroStat;
  final String? heroSubtext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          if (heroIcon != null) ...[
            _HeroOverview(
              icon: heroIcon!,
              color: heroColor ?? const Color(0xFF4A6CF7),
              value: heroStat,
              subtitle: heroSubtext,
            ),
            const SizedBox(height: 16),
          ],
          Text(description, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: metrics
                .map((metric) => _MetricCard(metric: metric))
                .toList(),
          ),
          const SizedBox(height: 28),
          const Text(
            'Highlights',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...insights.map(
            (insight) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      insight,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: _kReportPrimaryColor,
              foregroundColor: _kReportPrimaryTextColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () =>
                _showSnack(context, 'Automation assistant coming soon'),
            icon: const Icon(Icons.auto_mode),
            label: const Text('Create automation from report'),
          ),
        ],
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final ReportDetailItem metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 52) / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: metric.accentColor.withOpacity(0.16),
            child: Icon(metric.icon, color: metric.accentColor),
          ),
          const SizedBox(height: 12),
          Text(
            metric.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            metric.value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (metric.trend != null) ...[
            const SizedBox(height: 4),
            Text(metric.trend!, style: const TextStyle(color: Colors.black54)),
          ],
        ],
      ),
    );
  }
}

class ReportDetailItem {
  const ReportDetailItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.accentColor,
    this.trend,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? trend;
  final Color accentColor;
}

class _HeroOverview extends StatelessWidget {
  const _HeroOverview({
    required this.icon,
    required this.color,
    this.value,
    this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String? value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (value != null)
                  Text(
                    value!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
