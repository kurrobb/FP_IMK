import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/transaction.dart';
import '../widgets/accessible_button.dart';

class KonfirmasiTagihanScreen extends StatelessWidget {
  const KonfirmasiTagihanScreen({super.key});

  void _confirm(BuildContext context) {
    // Add transaction to AppData
    AppData().addTransaction(const Transaction(
      id: 'bill-1',
      merchantName: 'City Power Co.',
      category: 'Bills',
      time: 'Just now',
      amount: 450000,
      isDebit: true,
      iconPath: 'bills',
    ));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
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
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rp450.000 has been paid to City Power Co.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Done',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Review your transaction details before proceeding.',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // Biller card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.tealLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.bolt_rounded,
                              color: AppColors.tealDark, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Biller',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary)),
                            Text(
                              'City Power Co.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Amount breakdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _amountRow('Amount', 'Rp450.000'),
                        const Divider(height: 1, color: AppColors.divider),
                        _amountRow('Admin Fee', 'Rp0'),
                        const Divider(height: 1, color: AppColors.divider),
                        _amountRow('Total', 'Rp450.000', isTotal: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Pay from
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                          child: const Text(
                            'PAY FROM',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.divider),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: Colors.white,
                                    size: 22),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Main Checking',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Available: Rp12.450.000',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: AccessibleButton(
              label: 'Confirm & Pay',
              onPressed: () => _confirm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.w700,
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
