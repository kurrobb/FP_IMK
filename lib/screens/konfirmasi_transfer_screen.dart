import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/transaction.dart';

class KonfirmasiTransferScreen extends StatelessWidget {
  final String recipientName;
  final String bank;
  final String accountNumber;
  final double amount;

  const KonfirmasiTransferScreen({
    super.key,
    required this.recipientName,
    required this.bank,
    required this.accountNumber,
    required this.amount,
  });

  String _fmt(double v) => 'Rp${v.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      )}';

  void _confirm(BuildContext context) {
    // Add transaction to AppData
    AppData().addTransaction(Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      merchantName: recipientName,
      category: 'Transfer',
      time: 'Just now',
      amount: amount,
      isDebit: true,
      iconPath: 'transfer',
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
              'Transfer Successful!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              '${_fmt(amount)} has been sent to $recipientName.',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Sending Amount',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _fmt(amount),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Details card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _detailRow(
                          'From Account',
                          'Main Checking',
                          '...4892',
                          topBorder: false,
                        ),
                        _detailRow(
                          'To Account',
                          recipientName,
                          '...${ accountNumber.length >= 4 ? accountNumber.substring(accountNumber.length - 4) : accountNumber}',
                          subtitle: bank,
                        ),
                        _detailRow(
                          'Transfer Fee',
                          'Free',
                          'Rp0',
                          valueColor: AppColors.tealDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Warning
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGray,
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        left: BorderSide(color: AppColors.primary, width: 3),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.shield_outlined,
                            color: AppColors.primary, size: 18),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Please verify recipient details carefully. To protect your account, confirmed transfers process immediately and cannot be reversed.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Confirm button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => _confirm(context),
                icon: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Confirm & Send',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value,
    String trailing, {
    String? subtitle,
    Color? valueColor,
    bool topBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: topBorder
            ? const Border(top: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                if (subtitle != null)
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
