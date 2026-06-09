import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Pengaturan',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Profile header
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4), width: 2),
                    ),
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Ahmad Fadhil',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 4),
                        Text('1234 5678 9012',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                        SizedBox(height: 2),
                        Text('ahmad.fadhil@email.com',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 12)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.edit_outlined,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Transform.translate(
              offset: const Offset(0, -16),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Akun
                      _buildSectionTitle('Akun'),
                      const SizedBox(height: 8),
                      _buildMenuCard([
                        _buildMenuItem(
                            Icons.person_outline_rounded, 'Profil Saya', null),
                        _buildMenuItem(Icons.security_rounded, 'Keamanan Akun',
                            null),
                        _buildMenuItem(Icons.lock_outline_rounded,
                            'Ganti PIN / Password', null),
                        _buildMenuItem(Icons.fingerprint_rounded,
                            'Biometrik & Sidik Jari', null,
                            trailing: Switch(
                              value: true,
                              onChanged: (_) {},
                              activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                              thumbColor: WidgetStatePropertyAll(AppColors.primary),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            )),
                      ]),

                      const SizedBox(height: 20),

                      // Transaksi
                      _buildSectionTitle('Transaksi'),
                      const SizedBox(height: 8),
                      _buildMenuCard([
                        _buildMenuItem(Icons.receipt_long_outlined,
                            'Batas Transaksi Harian', 'Rp10.000.000'),
                        _buildMenuItem(Icons.notifications_none_rounded,
                            'Notifikasi Transaksi', null,
                            trailing: Switch(
                              value: true,
                              onChanged: (_) {},
                              activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                              thumbColor: WidgetStatePropertyAll(AppColors.primary),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            )),
                        _buildMenuItem(Icons.download_outlined,
                            'Unduh Mutasi Rekening', null),
                      ]),

                      const SizedBox(height: 20),

                      // Lainnya
                      _buildSectionTitle('Lainnya'),
                      const SizedBox(height: 8),
                      _buildMenuCard([
                        _buildMenuItem(
                            Icons.help_outline_rounded, 'Bantuan & FAQ', null),
                        _buildMenuItem(Icons.privacy_tip_outlined,
                            'Kebijakan Privasi', null),
                        _buildMenuItem(
                            Icons.info_outline_rounded, 'Tentang Aplikasi',
                            'v1.0.0'),
                      ]),

                      const SizedBox(height: 20),

                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.logout_rounded,
                              color: AppColors.debit, size: 20),
                          label: const Text('Keluar',
                              style: TextStyle(
                                  color: AppColors.debit,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.debit),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title.toUpperCase(), style: AppTextStyles.sectionHeader);
  }

  Widget _buildMenuCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: items
            .asMap()
            .entries
            .map((e) => Column(
                  children: [
                    e.value,
                    if (e.key < items.length - 1)
                      Divider(height: 1, color: AppColors.divider,
                          indent: 56, endIndent: 16),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String? subtitle,
      {Widget? trailing}) {
    return InkWell(
      onTap: () {},
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
                  Text(title, style: AppTextStyles.bodyLarge),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.bodySmall),
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
    );
  }
}
