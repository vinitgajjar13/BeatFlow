import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Account'),
          _buildSettingsTile(context, Icons.person_rounded, 'Managing Account',
              'Privacy, security, change email'),
          _buildSettingsTile(context, Icons.security_rounded, 'Security',
              'Password, two-factor authentication'),
          _buildSectionHeader(context, 'Preferences'),
          _buildSettingsTile(context, Icons.dark_mode_rounded, 'Appearance',
              'Dark mode, theme colors',
              isSwitch: true, value: true),
          _buildSettingsTile(context, Icons.notifications_rounded,
              'Notifications', 'Push notifications, email alerts'),
          _buildSettingsTile(
              context, Icons.language_rounded, 'Language', 'English (English)'),
          _buildSectionHeader(context, 'Music Quality'),
          _buildSettingsTile(context, Icons.high_quality_rounded,
              'Audio Quality', 'Very High'),
          _buildSettingsTile(context, Icons.download_for_offline_rounded,
              'Downloads', 'Download over Wi-Fi only',
              isSwitch: true, value: false),
          _buildSectionHeader(context, 'About'),
          _buildSettingsTile(
              context, Icons.info_rounded, 'About BeatFlow', 'Version 1.0.0'),
          _buildSettingsTile(context, Icons.help_rounded, 'Help & Support',
              'FAQs, contact us'),
          _buildSettingsTile(context, Icons.description_rounded,
              'Terms of Service', 'Read our legal documents'),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: AppTheme.geometry),
                elevation: 0,
              ),
              child: const Text('Delete Account',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
      BuildContext context, IconData icon, String title, String subtitle,
      {bool isSwitch = false, bool value = false}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      trailing: isSwitch
          ? Switch(
              value: value,
              onChanged: (v) {},
              activeThumbColor: AppTheme.primaryColor)
          : Icon(Icons.chevron_right_rounded,
              color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5),
              size: 20),
      onTap: isSwitch ? null : () {},
    );
  }
}
