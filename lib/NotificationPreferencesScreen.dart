import 'package:flutter/material.dart';

const Color _kAccentColor = Color(0xFF4A6CF7);

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  bool securityAlerts = true;
  bool deviceHealth = true;
  bool serviceUpdates = true;
  bool promotions = false;
  TimeOfDay quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay quietEnd = const TimeOfDay(hour: 7, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text('Notification preferences'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _handleSave,
            style: TextButton.styleFrom(
              foregroundColor: _kAccentColor,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _buildHeroCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('Notification types'),
          const SizedBox(height: 12),
          _buildSettingsCard(
            children: [
              _buildPreferenceToggle(
                title: 'Security alerts',
                subtitle: 'Door locks, cameras, intrusion events',
                value: securityAlerts,
                onChanged: (value) => setState(() => securityAlerts = value),
              ),
              const Divider(height: 28, color: Color(0xFFE8ECF6)),
              _buildPreferenceToggle(
                title: 'Device health',
                subtitle: 'Battery, connectivity, firmware status',
                value: deviceHealth,
                onChanged: (value) => setState(() => deviceHealth = value),
              ),
              const Divider(height: 28, color: Color(0xFFE8ECF6)),
              _buildPreferenceToggle(
                title: 'Service updates',
                subtitle: 'Cleaner visits, maintenance reminders',
                value: serviceUpdates,
                onChanged: (value) => setState(() => serviceUpdates = value),
              ),
              const Divider(height: 28, color: Color(0xFFE8ECF6)),
              _buildPreferenceToggle(
                title: 'Product tips & promos',
                subtitle: 'Occasional offers and best practices',
                value: promotions,
                onChanged: (value) => setState(() => promotions = value),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _buildSectionTitle('Quiet hours'),
          const SizedBox(height: 12),
          _buildSettingsCard(
            children: [
              _buildQuietHoursTile(context),
              const SizedBox(height: 10),
              const Text(
                'Mute push notifications during this window. Critical security alerts will always get through.',
                style: TextStyle(color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8ECF6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 10),
            blurRadius: 24,
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFEFF3FF),
            child: Icon(Icons.notifications_active, color: _kAccentColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Control how we reach you',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6),
                Text(
                  'Pick the alert types that matter most and set a calm window for nights or meetings.',
                  style: TextStyle(color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8ECF6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildQuietHoursTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFEFF3FF),
        child: Icon(Icons.nightlight_round, color: _kAccentColor),
      ),
      title: const Text(
        'Quiet hours',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(_quietHoursLabel(context)),
      trailing: const Icon(Icons.chevron_right),
      onTap: _editQuietHours,
    );
  }

  Widget _buildPreferenceToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, height: 1.3),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: _kAccentColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Future<void> _editQuietHours() async {
    final start = await showTimePicker(
      context: context,
      initialTime: quietStart,
    );
    if (start == null) return;
    final end = await showTimePicker(context: context, initialTime: quietEnd);
    if (end == null) return;
    setState(() {
      quietStart = start;
      quietEnd = end;
    });
  }

  String _quietHoursLabel(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return '${localizations.formatTimeOfDay(quietStart)} - ${localizations.formatTimeOfDay(quietEnd)}';
  }

  void _handleSave() {
    FocusScope.of(context).unfocus();
    _showSnack('Preferences saved');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
