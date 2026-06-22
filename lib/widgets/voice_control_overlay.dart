import 'package:flutter/material.dart';
import '../constants/colors.dart';

class VoiceControlOverlay extends StatefulWidget {
  final Function(String command) onCommand;
  final VoidCallback onDismiss;

  const VoiceControlOverlay({
    super.key,
    required this.onCommand,
    required this.onDismiss,
  });

  @override
  State<VoiceControlOverlay> createState() => _VoiceControlOverlayState();
}

class _VoiceControlOverlayState extends State<VoiceControlOverlay>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _wave1Controller;
  late AnimationController _wave2Controller;
  late AnimationController _enterController;

  late Animation<double> _enterAnimation;
  late Animation<double> _pulse;
  late Animation<double> _wave1;
  late Animation<double> _wave2;

  String? _recognizedText;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _commands = [
    {'label': 'Beranda', 'icon': Icons.home_rounded},
    {'label': 'Transfer', 'icon': Icons.swap_horiz_rounded},
    {'label': 'Riwayat', 'icon': Icons.history_rounded},
    {'label': 'Tagihan', 'icon': Icons.receipt_long_rounded},
    {'label': 'Pengaturan', 'icon': Icons.settings_rounded},
    {'label': 'QRIS', 'icon': Icons.qr_code_scanner_rounded},
  ];

  @override
  void initState() {
    super.initState();

    _enterController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _enterAnimation = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeOutBack,
    );
    _enterController.forward();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _wave1Controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat();
    _wave1 = Tween<double>(begin: 0.6, end: 1.4).animate(
      CurvedAnimation(parent: _wave1Controller, curve: Curves.easeOut),
    );

    _wave2Controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );
    _wave2Controller.forward(from: 0.3);
    _wave2 = Tween<double>(begin: 0.6, end: 1.4).animate(
      CurvedAnimation(parent: _wave2Controller, curve: Curves.easeOut),
    );
    _wave2Controller.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _wave1Controller.dispose();
    _wave2Controller.dispose();
    _enterController.dispose();
    super.dispose();
  }

  void _onCommandTapped(String label) async {
    setState(() {
      _recognizedText = '"$label"';
      _isProcessing = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    widget.onCommand(label);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _enterAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 40,
                spreadRadius: 2,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header label
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.tealLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.teal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Voice Control Aktif',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.tealDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Mic animation
              SizedBox(
                height: 130,
                width: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Wave 1
                    AnimatedBuilder(
                      animation: _wave1,
                      builder: (_, _) {
                        final opacity =
                            (1.4 - _wave1.value).clamp(0.0, 0.3);
                        return Transform.scale(
                          scale: _wave1.value,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: opacity),
                            ),
                          ),
                        );
                      },
                    ),
                    // Wave 2
                    AnimatedBuilder(
                      animation: _wave2,
                      builder: (_, _) {
                        final opacity =
                            (1.4 - _wave2.value).clamp(0.0, 0.2);
                        return Transform.scale(
                          scale: _wave2.value,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLight
                                  .withValues(alpha: opacity),
                            ),
                          ),
                        );
                      },
                    ),
                    // Mic button
                    AnimatedBuilder(
                      animation: _pulse,
                      builder: (_, _) => Transform.scale(
                        scale: _pulse.value,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryLight,
                                AppColors.primary,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Icon(
                            _isProcessing
                                ? Icons.graphic_eq_rounded
                                : Icons.mic_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Status text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _recognizedText != null
                    ? Column(
                        key: const ValueKey('recognized'),
                        children: [
                          Text(
                            'Dikenali:',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _recognizedText!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        key: const ValueKey('listening'),
                        children: [
                          Text(
                            'Mendengarkan...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pilih atau ketuk perintah di bawah',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 22),

              // Command chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: _commands.map((cmd) {
                  return _CommandChip(
                    label: cmd['label'] as String,
                    icon: cmd['icon'] as IconData,
                    onTap: _isProcessing
                        ? null
                        : () => _onCommandTapped(cmd['label'] as String),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Divider
              Container(height: 1, color: AppColors.border),
              const SizedBox(height: 12),

              // Cancel button
              GestureDetector(
                onTap: widget.onDismiss,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Batalkan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommandChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _CommandChip({
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  State<_CommandChip> createState() => _CommandChipState();
}

class _CommandChipState extends State<_CommandChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onTap == null) return;
        setState(() => _pressed = true);
        _scaleController.forward();
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        _scaleController.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
        _scaleController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _pressed
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.primary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: _pressed ? 0.4 : 0.18),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppColors.primary, size: 15),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
