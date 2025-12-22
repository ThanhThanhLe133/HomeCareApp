import 'package:flutter/material.dart';

import 'ReportDetailScreen.dart';
import 'subviews/subviews.dart';

const Color _kReportPrimaryColor = Color(0xFF4A6CF7);
const Color _kReportPrimaryTextColor = Colors.white;

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<String> _filters = const ['Week', 'Month', 'Year'];
  final List<String> _timeframeTitles = const [
    'This Week',
    'This Month',
    'This Year',
  ];
  final List<List<double>> _barValues = const [
    [42, 55, 61, 48, 64, 58],
    [80, 65, 92, 77, 101, 88],
    [520, 610, 640, 590, 670, 710],
  ];
  final List<List<String>> _barLabels = const [
    ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'],
    ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  ];

  final List<_ReportShortcut> _shortcuts = const [
    _ReportShortcut(
      title: 'Energy',
      description:
          'Detailed breakdown for consumption, cost, and savings insights.',
      icon: Icons.flash_on,
      color: Color(0xFFFFB657),
      metrics: [
        ReportDetailItem(
          icon: Icons.bar_chart,
          title: 'This month',
          value: '629 kWh',
          trend: '+3% vs Nov',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.attach_money,
          title: 'Cost to date',
          value: '\$101.4',
          trend: '-4% vs avg',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.brightness_5,
          title: 'Solar offset',
          value: '34%',
          trend: '+6% generation',
          accentColor: Color(0xFF8B5CF6),
        ),
        ReportDetailItem(
          icon: Icons.eco,
          title: 'Carbon saved',
          value: '18 kg',
          trend: 'Goal 24 kg',
          accentColor: Color(0xFF4A6CF7),
        ),
      ],
      insights: [
        'Living room dimming saved 9 kWh this week.',
        'Laundry automation trims 3.2 kWh per cycle when run after midnight.',
        'Solar peak shifted to 11:40 AM because of clear weather trends.',
      ],
    ),
    _ReportShortcut(
      title: 'Devices',
      description: 'Top consuming devices and opportunities to optimize usage.',
      icon: Icons.devices_other,
      color: Color(0xFF4A6CF7),
      metrics: [
        ReportDetailItem(
          icon: Icons.lightbulb_outline,
          title: 'Smart lamps',
          value: '329 kWh',
          trend: '-6% vs last month',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.videocam_outlined,
          title: 'Cameras',
          value: '89 kWh',
          trend: '+2% security patrols',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.tv_outlined,
          title: 'Entertainment',
          value: '229 kWh',
          trend: 'Gaming mode active',
          accentColor: Color(0xFF8B5CF6),
        ),
        ReportDetailItem(
          icon: Icons.toys_outlined,
          title: 'Climate',
          value: '198 kWh',
          trend: 'Fan automation suggested',
          accentColor: Color(0xFF4A6CF7),
        ),
      ],
      insights: [
        'Bedroom AC still runs 45 minutes after occupancy drops to zero.',
        'Replace two hallway bulbs with LED equivalents to save 12 kWh/week.',
        'Camera idle bitrate can be lowered at night for 7% battery savings.',
      ],
    ),
    _ReportShortcut(
      title: 'Insights',
      description:
          'Personalized recommendations and trends detected this week.',
      icon: Icons.auto_awesome,
      color: Color(0xFF8B5CF6),
      metrics: [
        ReportDetailItem(
          icon: Icons.schedule,
          title: 'Peak window',
          value: '6 PM - 9 PM',
          trend: '-8% vs last week',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.savings,
          title: 'Projected savings',
          value: '\$18/mo',
          trend: 'With suggested scenes',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.auto_mode,
          title: 'Routines active',
          value: '11',
          trend: '3 need review',
          accentColor: Color(0xFF8B5CF6),
        ),
        ReportDetailItem(
          icon: Icons.warning_amber_outlined,
          title: 'Alerts resolved',
          value: '5/6',
          trend: '1 pending action',
          accentColor: Color(0xFFEF4444),
        ),
      ],
      insights: [
        'Bathroom humidity stayed over threshold for 3 hours yesterday.',
        'Try combining Night Scene with Presence sensors to cut phantom loads.',
        'Turn on travel mode when geofence detects both owners away for 2+ hours.',
      ],
    ),
    _ReportShortcut(
      title: 'Activity',
      description: 'Full automation and alert timeline with exportable logs.',
      icon: Icons.timeline,
      color: Color(0xFF4ADEDE),
      metrics: [
        ReportDetailItem(
          icon: Icons.event_available,
          title: 'Automations',
          value: '42 runs',
          trend: '+5 today',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.notifications_active_outlined,
          title: 'Alerts',
          value: '6 triggered',
          trend: 'All acknowledged',
          accentColor: Color(0xFFEF4444),
        ),
        ReportDetailItem(
          icon: Icons.cleaning_services_outlined,
          title: 'Services',
          value: '3 visits',
          trend: 'Next on Thu',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.file_download_outlined,
          title: 'Exports',
          value: '2 reports',
          trend: 'Last 2 days ago',
          accentColor: Color(0xFF4A6CF7),
        ),
      ],
      insights: [
        'Vacuum paused twice due to motion detection in the living room.',
        'Irrigation skipped automatically during rainfall to keep goals on track.',
        'Energy alert triggered for pool heater at 15:20 but resolved quickly.',
      ],
    ),
  ];

  final List<_DeviceReport> _deviceReports = [
    _DeviceReport(
      usage: DeviceUsage(
        icon: Icons.lightbulb_outline,
        title: 'Smart lamps',
        kwh: '329.05',
        price: '\$101.4',
        accentColor: Color(0xFFFFB657),
      ),
      metrics: const [
        ReportDetailItem(
          icon: Icons.timer_outlined,
          title: 'Daily runtime',
          value: '5h 42m',
          trend: '-18 min vs avg',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.ssid_chart,
          title: 'Peak draw',
          value: '420 W',
          trend: '-6% with dimming',
          accentColor: Color(0xFF4A6CF7),
        ),
        ReportDetailItem(
          icon: Icons.emoji_objects_outlined,
          title: 'Scenes used',
          value: '7',
          trend: '2 idle',
          accentColor: Color(0xFF8B5CF6),
        ),
      ],
      insights: const [
        'Hallway lamps stay at 80% brightness past midnight.',
        'Sunrise scene skipped twice because of manual overrides.',
      ],
    ),
    _DeviceReport(
      usage: DeviceUsage(
        icon: Icons.videocam_outlined,
        title: 'Cameras',
        kwh: '89.05',
        price: '\$30.4',
        accentColor: Color(0xFF4ADEDE),
      ),
      metrics: const [
        ReportDetailItem(
          icon: Icons.security,
          title: 'Monitoring',
          value: '24/7',
          trend: 'Auto privacy 2x',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.sd_card_alert_outlined,
          title: 'Clips stored',
          value: '132',
          trend: '+14% events',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.wifi_tethering,
          title: 'Signal quality',
          value: 'Good',
          trend: 'Garage weak',
          accentColor: Color(0xFF4A6CF7),
        ),
      ],
      insights: const [
        'Porch camera bitrate spikes after sunset—consider IR-only mode.',
        'Garage camera reconnects daily at 03:10, check Wi-Fi extender.',
      ],
    ),
    _DeviceReport(
      usage: DeviceUsage(
        icon: Icons.tv_outlined,
        title: 'Entertainment',
        kwh: '229.05',
        price: '\$70.4',
        accentColor: Color(0xFF8B5CF6),
      ),
      metrics: const [
        ReportDetailItem(
          icon: Icons.videogame_asset,
          title: 'Gaming hours',
          value: '12.5h',
          trend: '+2.1h weekend',
          accentColor: Color(0xFF8B5CF6),
        ),
        ReportDetailItem(
          icon: Icons.movie_outlined,
          title: 'Streaming',
          value: '26 sessions',
          trend: 'HDR automatic',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.power_settings_new,
          title: 'Standby draw',
          value: '28 W',
          trend: 'Reduce with smart plug',
          accentColor: Color(0xFF4ADEDE),
        ),
      ],
      insights: const [
        'Console left in instant-on adds 5 kWh/week.',
        'Consider enabling eco audio mode for speakers at night.',
      ],
    ),
    _DeviceReport(
      usage: DeviceUsage(
        icon: Icons.toys_outlined,
        title: 'Climate',
        kwh: '198.22',
        price: '\$60.4',
        accentColor: Color(0xFF4A6CF7),
      ),
      metrics: const [
        ReportDetailItem(
          icon: Icons.air,
          title: 'Fan runtime',
          value: '9h 20m',
          trend: '+45 min hot day',
          accentColor: Color(0xFF4ADEDE),
        ),
        ReportDetailItem(
          icon: Icons.thermostat_outlined,
          title: 'Target temp',
          value: '23°C',
          trend: 'Hold 08:00-18:00',
          accentColor: Color(0xFFFFB657),
        ),
        ReportDetailItem(
          icon: Icons.water_drop,
          title: 'Humidity',
          value: '48%',
          trend: 'Stable',
          accentColor: Color(0xFF8B5CF6),
        ),
      ],
      insights: const [
        'Ceiling fan in office still spins after occupancy clears.',
        'Try eco-cool scene to ramp speed gradually before bedtime.',
      ],
    ),
  ];

  static const List<_Insight> _insights = [
    _Insight(
      icon: Icons.bolt_outlined,
      title: 'Evening peaks down',
      detail: 'Usage between 6-9 PM is 8% lower than last week.',
      color: Color(0xFFFFB657),
    ),
    _Insight(
      icon: Icons.waves_outlined,
      title: 'Laundry load spike',
      detail: 'Washer consumed 32 kWh yesterday, +14% vs average.',
      color: Color(0xFF4ADEDE),
    ),
    _Insight(
      icon: Icons.light_mode_outlined,
      title: 'Automation suggestion',
      detail: 'Consider dimming hallway lamps after 11 PM to save 6 kWh/week.',
      color: Color(0xFF8B5CF6),
    ),
  ];

  int _selectedRange = 1;

  @override
  Widget build(BuildContext context) {
    final timeframeLabel = _timeframeTitles[_selectedRange];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Header(),
              ),
              const SizedBox(height: 16),
              _buildPageHeading(context),
              const SizedBox(height: 12),
              _buildFilterChips(),
              const SizedBox(height: 12),
              _buildShortcutTabs(context),
              const SizedBox(height: 16),
              const EnergySummary(),
              const SizedBox(height: 20),
              StatisticsCard(
                timeframeLabel: timeframeLabel,
                values: _barValues[_selectedRange],
                labels: _barLabels[_selectedRange],
              ),
              const SizedBox(height: 20),
              const _GoalCard(),
              const SizedBox(height: 20),
              DevicesSection(
                devices: _deviceReports.map((r) => r.usage).toList(),
                onDeviceTap: _openDeviceReport,
              ),
              const SizedBox(height: 20),
              _InsightsCard(
                insights: _insights,
                onSeeAll: () => _openInsights(context),
              ),
              const SizedBox(height: 20),
              const _ActivityTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutTabs(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final shortcut = _shortcuts[index];
          return GestureDetector(
            onTap: () => _openShortcut(context, shortcut),
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: shortcut.color.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: shortcut.color.withOpacity(0.15),
                    child: Icon(shortcut.icon, color: shortcut.color),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    shortcut.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      shortcut.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: _shortcuts.length,
      ),
    );
  }

  void _openShortcut(BuildContext context, _ReportShortcut shortcut) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReportDetailScreen(
          title: shortcut.title,
          description: shortcut.description,
          metrics: shortcut.metrics,
          insights: shortcut.insights,
        ),
      ),
    );
  }

  Widget _buildPageHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Reports',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Updated 5 min ago · Energy & services overview',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: _kReportPrimaryColor,
              foregroundColor: _kReportPrimaryTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () => _showSnack('Download coming soon'),
            icon: const Icon(Icons.file_download_outlined),
            label: const Text('Export'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 12,
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedRange == index;
          return ChoiceChip(
            label: Text(_filters[index]),
            selected: isSelected,
            onSelected: (_) => setState(() => _selectedRange = index),
            selectedColor: const Color(0xFF4A6CF7),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }),
      ),
    );
  }

  void _openDeviceReport(DeviceUsage device, int index) {
    final report = _deviceReports[index];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReportDetailScreen(
          title: device.title,
          description: '${device.kwh} kWh · ${device.price}',
          metrics: report.metrics,
          insights: report.insights,
          heroIcon: device.icon,
          heroColor: device.accentColor,
          heroStat: '${device.kwh} kWh',
          heroSubtext: device.price,
        ),
      ),
    );
  }

  void _openInsights(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _InsightsListScreen(insights: _insights),
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.flag_outlined, color: Color(0xFF4A6CF7)),
                SizedBox(width: 8),
                Text(
                  'Monthly goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text('68% complete'),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'You have saved 12% more energy compared to last month. Keep routines optimized to reach the target.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.68,
                minHeight: 10,
                backgroundColor: const Color(0xFFE8ECFF),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF4A6CF7)),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Text(
                  '408 kWh',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text('of 600 kWh goal'),
                Spacer(),
                Icon(Icons.arrow_upward, color: Colors.green, size: 18),
                SizedBox(width: 4),
                Text(
                  'Best streak: 9 days',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsCard extends StatelessWidget {
  const _InsightsCard({required this.insights, required this.onSeeAll});

  final List<_Insight> insights;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onSeeAll,
              child: const Row(
                children: [
                  Text(
                    'Insights & tips',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('See all'),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...insights.map(
              (insight) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: insight.color.withOpacity(0.15),
                      child: Icon(insight.icon, color: insight.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight.detail,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsListScreen extends StatelessWidget {
  const _InsightsListScreen({required this.insights});

  final List<_Insight> insights;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights & tips'), centerTitle: true),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        itemBuilder: (context, index) {
          final insight = insights[index];
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: insight.color.withOpacity(0.15),
                  child: Icon(insight.icon, color: insight.color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        insight.detail,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemCount: insights.length,
      ),
    );
  }
}

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline();

  @override
  Widget build(BuildContext context) {
    const events = [
      _TimelineEvent(
        time: '07:30',
        title: 'Irrigation routine',
        description: 'Garden valves ran for 12 minutes.',
        tag: 'Automation',
        icon: Icons.water_drop,
        color: Color(0xFF60A5FA),
      ),
      _TimelineEvent(
        time: '11:45',
        title: 'Vacuum robot paused',
        description: 'Living room detected motion, run resumed at 12:10.',
        tag: 'Device',
        icon: Icons.cleaning_services_outlined,
        color: Color(0xFFFFB657),
      ),
      _TimelineEvent(
        time: '15:20',
        title: 'Energy alert',
        description: 'Pool heater exceeded daily target by 5 kWh.',
        tag: 'Alert',
        icon: Icons.warning_amber_rounded,
        color: Color(0xFFEF4444),
      ),
      _TimelineEvent(
        time: '21:15',
        title: 'Night scene enabled',
        description: 'Bedrooms dimmed to 30% brightness.',
        tag: 'Scene',
        icon: Icons.nightlight_round,
        color: Color(0xFF8B5CF6),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity timeline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(events.length, (index) {
              final event = events[index];
              final isLast = index == events.length - 1;
              return _TimelineRow(event: event, isLast: isLast);
            }),
          ],
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.event, required this.isLast});

  final _TimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: event.color,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 44,
                  margin: const EdgeInsets.only(top: 4),
                  color: const Color(0xFFE0E0E0),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Chip(
                  avatar: Icon(event.icon, size: 16, color: event.color),
                  label: Text(event.tag),
                  backgroundColor: event.color.withOpacity(0.15),
                  labelStyle: TextStyle(
                    color: event.color,
                    fontWeight: FontWeight.w600,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportShortcut {
  const _ReportShortcut({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.metrics,
    required this.insights,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<ReportDetailItem> metrics;
  final List<String> insights;
}

class _DeviceReport {
  const _DeviceReport({
    required this.usage,
    required this.metrics,
    required this.insights,
  });

  final DeviceUsage usage;
  final List<ReportDetailItem> metrics;
  final List<String> insights;
}

class _Insight {
  const _Insight({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Color color;
}

class _TimelineEvent {
  const _TimelineEvent({
    required this.time,
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
    required this.color,
  });

  final String time;
  final String title;
  final String description;
  final String tag;
  final IconData icon;
  final Color color;
}
