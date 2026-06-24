import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/custom_numpad.dart';
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
  bool _isLoading = false;
  String _account = '';

  bool get _isEwallet => widget.method == 'E-Wallet';
  List<String> get _items => _isEwallet ? _ewallets : _banks;
  String get _dropdownLabel => _isEwallet ? 'E-Wallet Tujuan' : 'Bank Tujuan';
  String get _accountFieldLabel => _isEwallet ? 'Phone Number' : 'Account Number';
  String get _placeholder => _isEwallet ? '0812 3456 7890' : '0000 0000 0000';

  String get _selectedItem {
    final first = _items.first;
    return _items.contains(_selectedItemState) ? _selectedItemState : first;
  }
  String _selectedItemState = '';

  static const _banks = ['BRI', 'BCA', 'Mandiri', 'BNI', 'CIMB', 'Danamon'];
  static const _ewallets = ['GoPay', 'OVO', 'Dana', 'LinkAja', 'ShopeePay'];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  void _onAccountKey(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_account.isNotEmpty) {
          _account = _account.substring(0, _account.length - 1);
        }
      } else if (key == 'mic') {
        // voice input placeholder
      } else {
        if (_account.length < 12) {
          _account += key;
        }
      }
    });
  }

  String _formatAccount(String account) {
    if (account.isEmpty) return '';
    final cleaned = account.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  void _verifyRecipient() async {
    if (_account.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter account number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InputNominalScreen(
          recipientName: widget.prefillName ?? 'Penerima Terverifikasi',
          bank: _selectedItem,
          accountNumber: _account.replaceAll(' ', ''),
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
          // Header & Bank Selection
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
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
                    Text(
                      _dropdownLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Semantics(
                      label: 'Select $_dropdownLabel, current: $_selectedItem',
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedItem,
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.textSecondary),
                            items: _items
                                .map((b) => DropdownMenuItem(
                                      value: b,
                                      child: Text(b),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() => _selectedItemState = v!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Account Number Display (Sticky)
          Container(
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _accountFieldLabel,
                  style: const TextStyle(
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
                  child: Center(
                    child: Text(
                      _account.isEmpty ? _placeholder : _formatAccount(_account),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: _account.isEmpty ? AppColors.textHint : AppColors.textPrimary,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Numpad
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomNumpad(
                onKeyPressed: _onAccountKey,
                showMic: true,
              ),
            ),
          ),

          // Verify button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoading || _account.isEmpty ? null : _verifyRecipient,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.person_add_rounded,
                        color: Colors.white, size: 20),
                label: Text(
                  _isLoading ? 'Verifying...' : 'Verify Recipient',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoading || _account.isEmpty
                      ? AppColors.surfaceDark
                      : AppColors.primary,
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
}
