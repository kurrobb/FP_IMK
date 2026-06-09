import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'pengaturan_aksesibilitas_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometric = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('FlexiBank'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGray,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.person_rounded,
                        color: AppColors.primary, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Ahmad Fadhil',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text('1234 5678 4892',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary)),
                        Text('ahmad.fadhil@email.com',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textHint)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined,
                        color: AppColors.primary, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _sectionLabel('ACCOUNT'),
            const SizedBox(height: 10),
            _menuCard([
              _menuItem(Icons.person_outline_rounded, 'My Profile', null),
              _menuItem(Icons.security_rounded, 'Account Security', null),
              _menuItem(Icons.lock_outline_rounded, 'Change PIN / Password', null),
              _menuItem(Icons.fingerprint_rounded, 'Biometric & Face ID', null,
                  trailing: Switch(
                    value: _biometric,
                    onChanged: (v) => setState(() => _biometric = v),
                    activeThumbColor: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )),
            ]),
            const SizedBox(height: 20),

            _sectionLabel('TRANSACTIONS'),
            const SizedBox(height: 10),
            _menuCard([
              _menuItem(Icons.receipt_long_outlined, 'Daily Transaction Limit',
                  'Rp10.000.000'),
              _menuItem(Icons.notifications_none_rounded, 'Transaction Notifications',
                  null,
                  trailing: Switch(
                    value: _notifications,
                    onChanged: (v) => setState(() => _notifications = v),
                    activeThumbColor: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )),
              _menuItem(Icons.download_outlined, 'Download Account Statement', null),
            ]),
            const SizedBox(height: 20),

            _sectionLabel('ACCESSIBILITY'),
            const SizedBox(height: 10),
            _menuCard([
              _menuItem(
                Icons.accessibility_new_rounded,
                'Accessibility Settings',
                null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PengaturanAksesibilitasScreen()),
                ),
              ),
            ]),
            const SizedBox(height: 20),

            _sectionLabel('OTHER'),
            const SizedBox(height: 10),
            _menuCard([
              _menuItem(Icons.help_outline_rounded, 'Help & FAQ', null),
              _menuItem(Icons.privacy_tip_outlined, 'Privacy Policy', null),
              _menuItem(Icons.info_outline_rounded, 'About App', 'v1.0.0'),
            ]),
            const SizedBox(height: 20),

            // Logout
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded,
                    color: AppColors.debit, size: 20),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.debit),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.debit),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 1.0,
        ),
      );

  Widget _menuCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          return Column(
            children: [
              e.value,
              if (e.key < items.length - 1)
                const Divider(
                    height: 1,
                    color: AppColors.divider,
                    indent: 56,
                    endIndent: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, String? subtitle,
      {Widget? trailing, VoidCallback? onTap}) {
    return Semantics(
      label: title,
      button: true,
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        )),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              trailing ??
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.textHint, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
