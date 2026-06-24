import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../models/transaction.dart';
import '../services/accessibility_provider.dart';
import '../widgets/accessible_button.dart';

class DetailTransaksiScreen extends StatelessWidget {
  final Transaction transaction;

  const DetailTransaksiScreen({super.key, required this.transaction});

  String _fmt(double v) => 'Rp${v.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      )}';

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.isDebit;
    final amountStr =
        '${isDebit ? '-' : '+'}${_fmt(transaction.amount)}';

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
                      SizedBox(height: 16 * spacingScale),

                      // Status icon
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.tealLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_rounded,
                            color: AppColors.tealDark, size: 44),
                      ),
                      SizedBox(height: 16 * spacingScale),
                      Text(
                        amountStr,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color:
                              isDebit ? AppColors.debit : AppColors.credit,
                        ),
                      ),
                      SizedBox(height: 6 * spacingScale),
                      Text(
                        'Paid to ${transaction.merchantName}',
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.textSecondary),
                      ),
                      SizedBox(height: 24 * spacingScale),

                      // Transaction Summary
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Transaction Summary',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Icon(Icons.receipt_long_outlined,
                                      color: AppColors.textSecondary, size: 20),
                                ],
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.divider),
                            _summaryRow(
                              'Status',
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.tealLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.check_circle_rounded,
                                        color: AppColors.tealDark, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.tealDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.divider),
                            _summaryRow('Date & Time',
                                value: 'Oct 24, 2023\nat 2:30 PM',
                                textAlign: TextAlign.right),
                            const Divider(height: 1, color: AppColors.divider),
                            _summaryRow('Category', value: transaction.category),
                            const Divider(height: 1, color: AppColors.divider),
                            _summaryRow(
                              'Payment Method',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.credit_card_rounded,
                                      color: AppColors.textSecondary, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Visa ending in\n•••• 4242',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12 * spacingScale),

                      // Reference ID
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16 * spacingScale),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceGray,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reference ID',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 6 * spacingScale),
                            Text(
                              'TXN-${transaction.id}827364510-ABC',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: EdgeInsets.fromLTRB(20 * spacingScale, 0, 20 * spacingScale, 24 * spacingScale),
                child: Column(
                  children: [
                    AccessibleElevatedButton(
                      onPressed: () {},
                      icon: Icons.download_rounded,
                      child: const Text(
                        'Download Receipt',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10 * spacingScale),
                    AccessibleOutlinedButton(
                      onPressed: () {},
                      icon: Icons.share_rounded,
                      child: const Text(
                        'Share Details',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryRow(String label,
      {String? value, Widget? child, TextAlign textAlign = TextAlign.right}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary)),
          ),
          Expanded(
            flex: 3,
            child: child ??
                Text(
                  value ?? '',
                  textAlign: textAlign,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
