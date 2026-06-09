import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionItem({super.key, required this.transaction, this.onTap});

  IconData _getIcon(String iconPath) {
    switch (iconPath) {
      case 'grocery':
        return Icons.local_grocery_store_outlined;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'transfer':
        return Icons.swap_horiz_rounded;
      case 'income':
        return Icons.account_balance_wallet_outlined;
      case 'food':
        return Icons.restaurant_outlined;
      case 'bills':
        return Icons.receipt_long_outlined;
      case 'transport':
        return Icons.directions_car_outlined;
      default:
        return Icons.attach_money_rounded;
    }
  }

  Color _getIconBg(String iconPath, bool isDebit) {
    if (!isDebit) return AppColors.creditLight;
    switch (iconPath) {
      case 'grocery':
        return const Color(0xFFE8F5E9);
      case 'entertainment':
        return const Color(0xFFFCE4EC);
      case 'food':
        return const Color(0xFFFFF8E1);
      case 'bills':
        return const Color(0xFFE3F2FD);
      case 'transport':
        return const Color(0xFFF3E5F5);
      default:
        return AppColors.surfaceGray;
    }
  }

  Color _getIconColor(String iconPath, bool isDebit) {
    if (!isDebit) return AppColors.credit;
    switch (iconPath) {
      case 'grocery':
        return const Color(0xFF2E7D32);
      case 'entertainment':
        return const Color(0xFFC62828);
      case 'food':
        return const Color(0xFFF57F17);
      case 'bills':
        return const Color(0xFF1565C0);
      case 'transport':
        return const Color(0xFF6A1B9A);
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatAmount(double amount) {
    return 'Rp${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          '${transaction.merchantName}, ${transaction.isDebit ? 'debit' : 'credit'} ${_formatAmount(transaction.amount)}',
      button: onTap != null,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color:
                        _getIconBg(transaction.iconPath, transaction.isDebit),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIcon(transaction.iconPath),
                    color: _getIconColor(
                        transaction.iconPath, transaction.isDebit),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.merchantName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${transaction.category} • ${transaction.time}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${transaction.isDebit ? '-' : '+'}${_formatAmount(transaction.amount)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color:
                        transaction.isDebit ? AppColors.debit : AppColors.credit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
