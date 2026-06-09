import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomNumpad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final bool showMic;

  const CustomNumpad({
    super.key,
    required this.onKeyPressed,
    this.showMic = true,
  });

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [showMic ? 'mic' : '', '0', 'backspace'],
    ];

    return Column(
      children: keys.map((row) {
        return Expanded(
          child: Row(
            children: row.map((key) {
              if (key.isEmpty && !showMic) {
                return Expanded(child: Container());
              }

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
                        onTap: () => onKeyPressed(key),
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
