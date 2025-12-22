import 'package:flutter/material.dart';

import 'AccountDetailScreen.dart';
import 'AccountEditScreen.dart';
import 'NotificationPreferencesScreen.dart';
import 'HelpSupportScreen.dart';
import 'ServiceSettingsScreen.dart';
import 'subviews/subviews.dart';

const Color _kControlActiveColor = Color(0xFF4A6CF7);

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Header(),
            ),
            ProfileTile(onTap: () => _openProfileEditor(context)),
            const SizedBox(height: 8),

            const SectionTitle("General"),
            SettingItem(
              icon: Icons.home_outlined,
              title: "Home Management",
              onTap: () => _openHomeManagement(context),
            ),
            SettingItem(
              icon: Icons.mic_none,
              title: "Voice Assistants",
              onTap: () => _openVoiceAssistants(context),
            ),
            SettingItem(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NotificationPreferencesScreen(),
                ),
              ),
            ),
            SettingItem(
              icon: Icons.shield_outlined,
              title: "Account & Security",
              onTap: () => _openSecurity(context),
            ),
            SettingItem(
              icon: Icons.swap_vert,
              title: "Linked Accounts",
              onTap: () => _openLinkedAccounts(context),
            ),
            SettingItem(
              icon: Icons.remove_red_eye_outlined,
              title: "App Appearance",
              onTap: () => _openAppearance(context),
            ),
            SettingItem(
              icon: Icons.settings_outlined,
              title: "Additional Settings",
              onTap: () => _openAdditionalSettings(context),
            ),

            const SizedBox(height: 12),
            const SectionTitle("Services"),
            SettingItem(
              icon: Icons.groups_outlined,
              title: "Service Activity",
              onTap: () => _openServiceSettings(context),
            ),
            SettingItem(
              icon: Icons.location_on_outlined,
              title: "Service Address",
              onTap: () => _openServiceAddress(context),
            ),
            const SettingItem(
              icon: Icons.attach_money,
              title: "Payment & Billing",
              enabled: false,
            ),

            const SizedBox(height: 12),
            const SectionTitle("Support"),
            SettingItem(
              icon: Icons.bar_chart_outlined,
              title: "Data & Analytics",
              onTap: () => _openDataAnalytics(context),
            ),
            SettingItem(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () => _openHelpSupport(context),
            ),
            SettingItem(
              icon: Icons.logout,
              title: "Logout",
              isDanger: true,
              onTap: () => _confirmLogout(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _openHomeManagement(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Home management',
          items: [
            DetailItem(
              icon: Icons.home,
              title: 'My Home',
              subtitle: '8 rooms · 32 devices',
              onTap: () => _showSnack(context, 'Switching to My Home...'),
            ),
            DetailItem(
              icon: Icons.apartment,
              title: 'My Girlfriend Home',
              subtitle: '4 rooms · 21 devices',
              onTap: () => _showSnack(context, 'Opening Girlfriend Home...'),
            ),
            DetailItem(
              icon: Icons.house_siding,
              title: 'My Parent House',
              subtitle: '6 rooms · 18 devices',
              onTap: () => _showSnack(context, 'Opening Parent House...'),
            ),
            DetailItem(
              icon: Icons.add_circle_outline,
              title: 'Create new home',
              onTap: () => _showSnack(context, 'Create home wizard coming soon'),
            ),
          ],
        ),
      ),
    );
  }

  void _openProfileEditor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AccountEditScreen()),
    );
  }

  void _openVoiceAssistants(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Voice assistants',
          items: [
            DetailItem(
              icon: Icons.apple,
              title: 'Apple Siri',
              subtitle: 'Paired yesterday · Living Room',
              onTap: () => _showSnack(context, 'Siri already connected'),
            ),
            DetailItem(
              icon: Icons.mic_none,
              title: 'Google Assistant',
              subtitle: 'Tap to connect',
              onTap: () => _showSnack(context, 'Connecting Google Assistant...'),
            ),
            DetailItem(
              icon: Icons.speaker_group_outlined,
              title: 'Amazon Alexa',
              subtitle: 'Tap to connect',
              onTap: () => _showSnack(context, 'Connecting Amazon Alexa...'),
            ),
          ],
        ),
      ),
    );
  }

  void _openHelpSupport(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
    );
  }

  void _openServiceSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ServiceSettingsScreen(),
      ),
    );
  }

  void _openSecurity(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Account & security',
          items: [
            DetailItem(
              icon: Icons.lock_outline,
              title: 'Change password',
              trailing: const Icon(Icons.check_circle, color: Color(0xFF4A6CF7)),
            ),
            DetailItem(
              icon: Icons.fingerprint,
              title: 'Face ID / Fingerprint',
              subtitle: 'Currently enabled',
              trailing: const Icon(Icons.circle_outlined),
            ),
            DetailItem(
              icon: Icons.sms_outlined,
              title: 'Two-factor authentication',
              subtitle: 'Recommended',
              trailing: const Icon(Icons.circle_outlined),
            ),
          ],
        ),
      ),
    );
  }

  void _openLinkedAccounts(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Linked accounts',
          items: [
            DetailItem(
              icon: Icons.facebook,
              title: 'Facebook',
              subtitle: 'Connected',
              onTap: () => _showSnack(context, 'Disconnecting Facebook...'),
            ),
            DetailItem(
              icon: Icons.apple,
              title: 'Apple ID',
              subtitle: 'Tap to connect',
              onTap: () => _showSnack(context, 'Connecting Apple ID...'),
            ),
            DetailItem(
              icon: Icons.alternate_email,
              title: 'Email login',
              subtitle: 'Primary access',
              onTap: () => _showSnack(context, 'Email login verified'),
            ),
          ],
        ),
      ),
    );
  }

  void _openAppearance(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Appearance',
          items: [
            DetailItem(
              icon: Icons.wb_sunny_outlined,
              title: 'Light mode',
              trailing: Radio<bool>(
                value: true,
                groupValue: true,
                activeColor: _kControlActiveColor,
                onChanged: (_) {},
              ),
            ),
            DetailItem(
              icon: Icons.nightlight_round,
              title: 'Dark mode',
              trailing: Radio<bool>(
                value: false,
                groupValue: true,
                activeColor: _kControlActiveColor,
                onChanged: (_) {},
              ),
              onTap: () => _showSnack(context, 'Switching to dark mode...'),
            ),
            DetailItem(
              icon: Icons.auto_awesome,
              title: 'Match system',
              trailing: Radio<bool>(
                value: false,
                groupValue: true,
                activeColor: _kControlActiveColor,
                onChanged: (_) {},
              ),
              onTap: () => _showSnack(context, 'Matching system theme...'),
            ),
          ],
        ),
      ),
    );
  }

  void _openAdditionalSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Additional settings',
          items: [
            DetailItem(
              icon: Icons.language,
              title: 'Language & region',
              subtitle: 'English · United States',
              onTap: () => _showSnack(context, 'Language selector coming soon'),
            ),
            DetailItem(
              icon: Icons.spatial_audio_off,
              title: 'Accessibility',
              onTap: () => _showSnack(context, 'Accessibility tools opening...'),
            ),
            DetailItem(
              icon: Icons.storage,
              title: 'Storage & backups',
              subtitle: 'Backed up 2 days ago',
              onTap: () => _showSnack(context, 'Backup options coming soon'),
            ),
          ],
        ),
      ),
    );
  }

  void _openServiceAddress(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Service addresses',
          items: [
            DetailItem(
              icon: Icons.home_work_outlined,
              title: '123 Ocean Drive',
              subtitle: 'Primary visit address',
              onTap: () => _showSnack(context, 'Using 123 Ocean Drive'),
            ),
            DetailItem(
              icon: Icons.location_on_outlined,
              title: '45 Sunset Blvd',
              subtitle: 'Secondary property',
              onTap: () => _showSnack(context, 'Using 45 Sunset Blvd'),
            ),
            DetailItem(
              icon: Icons.add_location_alt,
              title: 'Add new address',
              onTap: () => _showSnack(context, 'Add address flow coming soon'),
            ),
          ],
        ),
      ),
    );
  }

  void _openDataAnalytics(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountDetailScreen(
          title: 'Data & analytics',
          items: [
            DetailItem(
              icon: Icons.insert_chart_outlined,
              title: 'Usage exports',
              subtitle: 'CSV · Last exported 3 days ago',
              onTap: () => _showSnack(context, 'Export started. Check email soon.'),
            ),
            DetailItem(
              icon: Icons.timeline,
              title: 'Automation insights',
              subtitle: 'Identify routines you rarely use',
              onTap: () => _showSnack(context, 'Generating automation insights...'),
            ),
            DetailItem(
              icon: Icons.bolt_outlined,
              title: 'Energy impact',
              subtitle: 'Compare rooms and devices',
              onTap: () => _showSnack(context, 'Compiling energy impact report...'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('You can always log back in to manage your home.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _showSnack(context, 'Signed out of HomeCare');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
