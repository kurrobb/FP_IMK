import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/transaction.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_access_button.dart';
import '../widgets/transaction_item.dart';
import 'detail_transaksi_screen.dart';
import 'qris_screen.dart';
import 'tagihan_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const HomeScreen({super.key, required this.onNavTap});

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
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            BalanceCard(
              balance: DummyData.balance,
              accountNumber: DummyData.accountNumber,
            ),
            const SizedBox(height: 24),

            // Quick Access
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'QUICK ACCESS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      QuickAccessButton(
                        icon: Icons.swap_horiz_rounded,
                        label: 'Transfer',
                        onTap: () => onNavTap(1),
                      ),
                      QuickAccessButton(
                        icon: Icons.qr_code_scanner_rounded,
                        label: 'QRIS',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const QrisScreen()),
                        ),
                      ),
                      QuickAccessButton(
                        icon: Icons.receipt_long_outlined,
                        label: 'Bills',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TagihanScreen()),
                        ),
                      ),
                      QuickAccessButton(
                        icon: Icons.history_rounded,
                        label: 'History',
                        onTap: () => onNavTap(2),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // TODAY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'TODAY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DummyData.todayTransactions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final tx = DummyData.todayTransactions[index];
                  return TransactionItem(
                    transaction: tx,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailTransaksiScreen(transaction: tx)),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // YESTERDAY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'YESTERDAY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DummyData.yesterdayTransactions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final tx = DummyData.yesterdayTransactions[index];
                  return TransactionItem(
                    transaction: tx,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailTransaksiScreen(transaction: tx)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
