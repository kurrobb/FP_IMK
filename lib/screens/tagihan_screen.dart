import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import 'detail_tagihan_screen.dart';

class _BillCategory {
  final String name;
  final IconData icon;
  final Color bg;
  final Color iconColor;
  const _BillCategory(this.name, this.icon, this.bg, this.iconColor);
}

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({super.key});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  String _searchQuery = '';

  static const _categories = [
    _BillCategory('Electricity', Icons.bolt_rounded,
        Color(0xFF0D2E6E), Colors.white),
    _BillCategory('Water', Icons.water_drop_rounded,
        Color(0xFF26C6A2), Colors.white),
    _BillCategory('Internet', Icons.wifi_rounded,
        Color(0xFFFF7043), Colors.white),
    _BillCategory('Mobile', Icons.smartphone_rounded,
        Color(0xFF7986CB), Colors.white),
    _BillCategory('Gas', Icons.local_fire_department_rounded,
        Color(0xFFEF5350), Colors.white),
  ];

  List<_BillCategory> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;
    return _categories
        .where((c) =>
            c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final spacingScale = accessibilityProvider.getSpacingMultiplier();
        final buttonScale = accessibilityProvider.getButtonSizeMultiplier();

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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(20 * spacingScale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4 * spacingScale),
                const Text(
                  'Pay Bills',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6 * spacingScale),
                const Text(
                  'Select a biller to make a payment.',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
                SizedBox(height: 16 * spacingScale),

                // Search
                Container(
                  height: 52 * spacingScale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: 'Search biller name or ID...',
                      hintStyle:
                          TextStyle(color: AppColors.textHint, fontSize: 15),
                      prefixIcon: Icon(Icons.search_rounded,
                          color: AppColors.textHint, size: 22),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(height: 24 * spacingScale),

                // Categories
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 14 * spacingScale),
                if (_filteredCategories.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * spacingScale),
                    child: const Center(
                      child: Text(
                        'No categories found',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: _filteredCategories.length,
                    itemBuilder: (ctx, i) {
                      final c = _filteredCategories[i];
                      return Semantics(
                        label: c.name,
                        button: true,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailTagihanScreen(category: c.name),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: c.bg,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(c.icon, color: c.iconColor, size: 28),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                SizedBox(height: 28 * spacingScale),

                // Saved Billers
                const Text(
                  'Saved Billers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12 * spacingScale),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.bolt_rounded,
                            color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City Power Co.',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Acc: •••• 4092',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      Semantics(
                        label: 'Pay City Power Co.',
                        button: true,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DetailTagihanScreen(
                                  category: 'Electricity'),
                            ),
                          ),
                          child: Container(
                            height: 36 * buttonScale,
                            padding: EdgeInsets.symmetric(horizontal: 20 * buttonScale),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
