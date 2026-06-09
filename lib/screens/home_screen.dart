import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../models/transaction.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_access_button.dart';
import '../widgets/transaction_item.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const HomeScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            snap: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Selamat Datang,',
                        style: TextStyle(
                            fontSize: 11, color: Colors.white60, height: 1)),
                    Text('Ahmad Fadhil',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.3)),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded,
                    color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 4),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blue top area that blends with balance card
                Container(
                  color: AppColors.primary,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      BalanceCard(
                        balance: DummyData.balance,
                        accountName: DummyData.accountName,
                        accountNumber: DummyData.accountNumber,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // White content area
                Container(
                  color: AppColors.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Quick Access Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('QUICK ACCESS',
                                style: AppTextStyles.sectionHeader),
                            const SizedBox(height: 14),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.6,
                              children: [
                                QuickAccessButton(
                                  icon: Icons.swap_horiz_rounded,
                                  label: 'Transfer',
                                  onTap: () => onNavTap(1),
                                ),
                                QuickAccessButton(
                                  icon: Icons.qr_code_scanner_rounded,
                                  label: 'QRIS',
                                  onTap: () {},
                                ),
                                QuickAccessButton(
                                  icon: Icons.receipt_long_outlined,
                                  label: 'Tagihan',
                                  onTap: () {},
                                ),
                                QuickAccessButton(
                                  icon: Icons.history_rounded,
                                  label: 'Riwayat',
                                  onTap: () => onNavTap(2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // TODAY section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('TODAY', style: AppTextStyles.sectionHeader),
                            GestureDetector(
                              onTap: () => onNavTap(2),
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: DummyData.todayTransactions.length,
                            separatorBuilder: (_, _) => Divider(
                              height: 1,
                              color: AppColors.divider,
                            ),
                            itemBuilder: (context, index) => TransactionItem(
                              transaction: DummyData.todayTransactions[index],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // YESTERDAY section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text('KEMARIN',
                            style: AppTextStyles.sectionHeader),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: DummyData.yesterdayTransactions.length,
                            separatorBuilder: (_, _) => Divider(
                              height: 1,
                              color: AppColors.divider,
                            ),
                            itemBuilder: (context, index) => TransactionItem(
                              transaction:
                                  DummyData.yesterdayTransactions[index],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
