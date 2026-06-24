import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../widgets/accessible_button.dart';
import '../widgets/custom_numpad.dart';
import 'konfirmasi_transfer_screen.dart';

class InputNominalScreen extends StatefulWidget {
  final String recipientName;
  final String bank;
  final String accountNumber;

  const InputNominalScreen({
    super.key,
    required this.recipientName,
    required this.bank,
    required this.accountNumber,
  });

  @override
  State<InputNominalScreen> createState() => _InputNominalScreenState();
}

class _InputNominalScreenState extends State<InputNominalScreen> {
  String _amount = '0';
  static const double _availableBalance = 4250000;

  String get _formattedAmount {
    if (_amount == '0') return '0';
    final n = int.tryParse(_amount) ?? 0;
    return n.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  bool get _canContinue => _amount != '0' && _amount.isNotEmpty;

  void _onKey(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_amount.length <= 1) {
          _amount = '0';
        } else {
          _amount = _amount.substring(0, _amount.length - 1);
        }
      } else if (key == 'mic') {
        // voice input placeholder
      } else {
        if (_amount == '0') {
          _amount = key;
        } else {
          if (_amount.length < 12) _amount += key;
        }
      }
    });
  }

  String _formatBalance(double v) {
    return 'Rp${v.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text('Transfer'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppColors.border),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 16 * spacingScale),

              // Recipient card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * spacingScale),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          widget.recipientName.isNotEmpty
                              ? widget.recipientName[0].toUpperCase()
                              : 'R',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 12 * spacingScale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sending to',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary),
                            ),
                            Text(
                              widget.recipientName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${widget.bank} ${widget.accountNumber}',
                              style: const TextStyle(
                                  fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.verified_rounded,
                          color: AppColors.teal, size: 24),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 28 * spacingScale),

              // Amount display
              const Text(
                'Enter Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8 * spacingScale),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * spacingScale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      'Rp ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      _formattedAmount,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: _canContinue
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6 * spacingScale),
              Text(
                'Available Balance: ${_formatBalance(_availableBalance)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: 20 * spacingScale),

              // Numpad
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * spacingScale),
                  child: CustomNumpad(
                    onKeyPressed: _onKey,
                    showMic: true,
                  ),
                ),
              ),

              // Continue button
              Padding(
                padding: EdgeInsets.fromLTRB(20 * spacingScale, 8 * spacingScale, 20 * spacingScale, 24 * spacingScale),
                child: AccessibleElevatedButton(
                  onPressed: _canContinue
                      ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => KonfirmasiTransferScreen(
                                recipientName: widget.recipientName,
                                bank: widget.bank,
                                accountNumber: widget.accountNumber,
                                amount: double.tryParse(_amount) ?? 0,
                              ),
                            ),
                          )
                      : null,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _canContinue
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
