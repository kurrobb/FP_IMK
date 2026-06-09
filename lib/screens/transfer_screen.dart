import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'input_penerima_screen.dart';

class _FrequentContact {
  final String name;
  final String bank;
  final String account;
  final String initials;
  final Color color;
  const _FrequentContact(
      this.name, this.bank, this.account, this.initials, this.color);
}

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  static const _methods = [
    ('Bank Account', Icons.account_balance_rounded, AppColors.primary),
    ('E-Wallet', Icons.account_balance_wallet_rounded, AppColors.teal),
  ];

  static const _contacts = [
    _FrequentContact(
        'Marcus Johnson', 'Citibank', '•••• 4291', 'MJ', Color(0xFF1565C0)),
    _FrequentContact(
        'Elena Rodriguez', 'Chase', '•••• 8832', 'ER', Color(0xFF6A1B9A)),
    _FrequentContact(
        'Samuel Roberts', 'E-Wallet', '+1 (555) 0192', 'SR', Color(0xFFBF360C)),
  ];

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
            // Search bar
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const TextField(
                style: TextStyle(fontSize: 15, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Name, @username, or phone',
                  hintStyle:
                      TextStyle(color: AppColors.textHint, fontSize: 15),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: AppColors.textHint, size: 22),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Transfer Methods
            const Text(
              'Transfer Methods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: _methods.map((m) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: m == _methods.first ? 8 : 0,
                        left: m == _methods.last ? 8 : 0),
                    child: Semantics(
                      label: m.$1,
                      button: true,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => InputPenerimaScreen(method: m.$1),
                          ),
                        ),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: m.$3 == AppColors.primary
                                      ? AppColors.primary
                                      : AppColors.teal,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(m.$2,
                                    color: Colors.white, size: 26),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                m.$1,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // Frequent
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Frequent',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contacts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final c = _contacts[i];
                return Semantics(
                  label: '${c.name}, ${c.bank} ${c.account}',
                  button: true,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InputPenerimaScreen(
                          method: 'Bank Account',
                          prefillName: c.name,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: c.color,
                            child: Text(
                              c.initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${c.bank} ${c.account}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded,
                              color: AppColors.textHint, size: 22),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
