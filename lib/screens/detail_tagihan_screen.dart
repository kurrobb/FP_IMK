import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../widgets/accessible_button.dart';
import 'konfirmasi_tagihan_screen.dart';

class DetailTagihanScreen extends StatelessWidget {
  final String category;

  const DetailTagihanScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final spacingScale = accessibilityProvider.getSpacingMultiplier();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: AppColors.primary, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('FlexiBank'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppColors.border),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20 * spacingScale),
                  child: Column(
                    children: [
                      SizedBox(height: 12 * spacingScale),

                      // Service icon + name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.border, width: 2),
                              ),
                              child: const Icon(Icons.bolt_rounded,
                                  color: AppColors.primary, size: 36),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'City Power Co.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Electricity Bill - August 2023',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16 * spacingScale),

                      // Bill details
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                              child: const Text(
                                'BILL DETAILS',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.divider),
                            _billRow('Account Holder', 'Jonathan Doe'),
                            const Divider(height: 1, color: AppColors.divider),
                            _billRow('Customer ID', '109-882-7734'),
                            const Divider(height: 1, color: AppColors.divider),
                            _billRow('Due Date', 'Sep 15, 2023',
                                valueColor: AppColors.debit),
                          ],
                        ),
                      ),
                      SizedBox(height: 16 * spacingScale),

                      // Total amount
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20 * spacingScale),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceGray,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              'Total Amount Due',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rp450.000',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Pay Now button
              Padding(
                padding: EdgeInsets.fromLTRB(20 * spacingScale, 0, 20 * spacingScale, 24 * spacingScale),
                child: AccessibleElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const KonfirmasiTagihanScreen(),
                    ),
                  ),
                  icon: Icons.account_balance_wallet_rounded,
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _billRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14, color: AppColors.textSecondary)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
