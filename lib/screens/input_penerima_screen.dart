import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'input_nominal_screen.dart';

class InputPenerimaScreen extends StatefulWidget {
  final String method;
  final String? prefillName;

  const InputPenerimaScreen({
    super.key,
    required this.method,
    this.prefillName,
  });

  @override
  State<InputPenerimaScreen> createState() => _InputPenerimaScreenState();
}

class _InputPenerimaScreenState extends State<InputPenerimaScreen> {
  final _accountController = TextEditingController();
  String _selectedBank = 'BRI';

  static const _banks = ['BRI', 'BCA', 'Mandiri', 'BNI', 'CIMB', 'Danamon'];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'New Transfer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Enter the exact account number below to\nlocate the recipient.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            // Bank dropdown
            const Text(
              'Bank/E-Wallet Tujuan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label: 'Select bank, current: $_selectedBank',
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBank,
                    isExpanded: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textSecondary),
                    items: _banks
                        .map((b) => DropdownMenuItem(
                              value: b,
                              child: Text(b),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedBank = v!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Account number
            const Text(
              'Account Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: 2,
                ),
                decoration: const InputDecoration(
                  hintText: '0000 0000 0000',
                  hintStyle: TextStyle(
                    color: AppColors.textHint,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
              ),
            ),
            const Spacer(),

            // Verify button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InputNominalScreen(
                      recipientName: widget.prefillName ?? 'Penerima',
                      bank: _selectedBank,
                      accountNumber: _accountController.text.isEmpty
                          ? '8472 9011 3345'
                          : _accountController.text,
                    ),
                  ),
                ),
                icon: const Icon(Icons.person_add_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Verify Recipient',
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
