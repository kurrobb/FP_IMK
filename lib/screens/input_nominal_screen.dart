import 'package:flutter/material.dart';
import '../constants/colors.dart';
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
          const SizedBox(height: 16),

          // Recipient card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  const SizedBox(width: 12),
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

          const SizedBox(height: 28),

          // Amount display
          const Text(
            'Enter Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          const SizedBox(height: 6),
          Text(
            'Available Balance: ${_formatBalance(_availableBalance)}',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 20),

          // Numpad
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildNumpad(),
            ),
          ),

          // Continue button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canContinue
                      ? AppColors.primary
                      : AppColors.surfaceDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['mic', '0', 'backspace'],
    ];

    return Column(
      children: keys.map((row) {
        return Expanded(
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Semantics(
                    label: key == 'backspace'
                        ? 'Delete'
                        : key == 'mic'
                            ? 'Voice input'
                            : key,
                    button: true,
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => _onKey(key),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Center(child: _keyContent(key)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _keyContent(String key) {
    if (key == 'backspace') {
      return const Icon(Icons.backspace_outlined,
          color: AppColors.textPrimary, size: 24);
    }
    if (key == 'mic') {
      return const Icon(Icons.mic_none_rounded,
          color: AppColors.textSecondary, size: 26);
    }
    return Text(
      key,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
