import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../main.dart';
import '../services/accessibility_provider.dart';
import '../services/auth_service.dart';
import '../utils/formatters.dart';
import '../utils/validation_helpers.dart';

/// Register Screen - User account creation with KTP verification
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  late SharedPreferences _prefs;
  bool _ktpScanned = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedForm();
  }

  /// Load previously saved form data from SharedPreferences
  Future<void> _loadSavedForm() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      
      final savedEmail = _prefs.getString(RegistrationPersistenceKeys.emailKey);
      final savedPassword = _prefs.getString(RegistrationPersistenceKeys.passwordKey);
      final savedPhone = _prefs.getString(RegistrationPersistenceKeys.phoneKey);
      final savedKtpScanned = _prefs.getBool(RegistrationPersistenceKeys.ktpScannedKey) ?? false;

      setState(() {
        if (savedEmail != null) _emailCtrl.text = savedEmail;
        if (savedPassword != null) _passCtrl.text = savedPassword;
        if (savedPhone != null) _phoneCtrl.text = savedPhone;
        _ktpScanned = savedKtpScanned;
      });
    } catch (e) {
      debugPrint('Error loading saved form: $e');
    }
  }

  /// Save form data to SharedPreferences
  Future<void> _saveFormData() async {
    try {
      await _prefs.setString(RegistrationPersistenceKeys.emailKey, _emailCtrl.text);
      await _prefs.setString(RegistrationPersistenceKeys.passwordKey, _passCtrl.text);
      await _prefs.setString(RegistrationPersistenceKeys.phoneKey, _phoneCtrl.text);
      await _prefs.setBool(RegistrationPersistenceKeys.ktpScannedKey, _ktpScanned);
    } catch (e) {
      debugPrint('Error saving form data: $e');
    }
  }

  /// Show error message via SnackBar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.debit,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success message via SnackBar
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.credit,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Handle KTP scan button tap
  Future<void> _onScanKtpTap() async {
    // TODO: Implement camera/image picker integration with image_picker package
    // For now, placeholder implementation
    setState(() => _ktpScanned = true);
    _showSuccess('KTP scanned successfully! (Placeholder)');
    await _saveFormData();
  }

  /// Handle registration - Validate and submit
  Future<void> _onContinueTap() async {
    // Validate all fields
    final emailError = ValidationHelper.validateEmail(_emailCtrl.text);
    final passwordError = ValidationHelper.validatePassword(_passCtrl.text);
    final phoneError = ValidationHelper.validatePhone(_phoneCtrl.text);

    if (emailError != null) {
      _showError(emailError);
      return;
    }
    if (passwordError != null) {
      _showError(passwordError);
      return;
    }
    if (phoneError != null) {
      _showError(phoneError);
      return;
    }

    if (!_ktpScanned) {
      _showError('Please scan your KTP first');
      return;
    }

    // Save form data before registration
    await _saveFormData();

    setState(() => _isLoading = true);

    try {
      // TODO: Implement backend registration API call here
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // On successful registration:
      // 1. Call AuthService.login()
      AuthService.login();

      // 2. Clear saved form data (optional)
      await Future.wait([
        _prefs.remove(RegistrationPersistenceKeys.emailKey),
        _prefs.remove(RegistrationPersistenceKeys.passwordKey),
        _prefs.remove(RegistrationPersistenceKeys.phoneKey),
        _prefs.remove(RegistrationPersistenceKeys.ktpScannedKey),
      ]);

      // 3. Navigate to MainShell (home screen)
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainShell()),
          (route) => false,
        );
      }
    } catch (e) {
      _showError('Registration failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final spacingMultiplier = accessibilityProvider.getSpacingMultiplier();
        final buttonMultiplier = accessibilityProvider.getButtonSizeMultiplier();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24 * spacingMultiplier,
                100 * spacingMultiplier,
                24 * spacingMultiplier,
                32 * spacingMultiplier,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Heading ──────────────────────────────────────────
                  Text(
                    'Create Account',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 28,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 23 * spacingMultiplier),

                  // ── Form fields ───────────────────────────────────────
                  _InputField(
                    label: 'Email Address',
                    placeholder: 'rexy@example.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    spacingMultiplier: spacingMultiplier,
                  ),
                  SizedBox(height: 9 * spacingMultiplier),
                  _InputField(
                    label: 'Password',
                    placeholder: 'password',
                    controller: _passCtrl,
                    obscure: true,
                    spacingMultiplier: spacingMultiplier,
                  ),
                  SizedBox(height: 9 * spacingMultiplier),
                  _InputField(
                    label: 'Phone Number',
                    placeholder: '0815 7897 9853',
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    spacingMultiplier: spacingMultiplier,
                  ),
                  SizedBox(height: 16 * spacingMultiplier),

                  // ── Foto KTP card ─────────────────────────────────────
                  _FotoKtpCard(
                    isScanned: _ktpScanned,
                    onScanTap: _isLoading ? null : _onScanKtpTap,
                    spacingMultiplier: spacingMultiplier,
                  ),
                  SizedBox(height: 32 * spacingMultiplier),

                  // ── Continue button ───────────────────────────────────
                  _ContinueButton(
                    onTap: _isLoading ? null : _onContinueTap,
                    isLoading: _isLoading,
                    buttonMultiplier: buttonMultiplier,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Input Field ──────────────────────────────────────────────────────────────
class _InputField extends StatefulWidget {
  const _InputField({
    required this.label,
    required this.placeholder,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    required this.spacingMultiplier,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final double spacingMultiplier;

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  late bool _showPassword;

  @override
  void initState() {
    super.initState();
    _showPassword = !widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4 * widget.spacingMultiplier),
          child: Text(
            widget.label,
            style: AppTextStyles.h3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: 0.16,
            ),
          ),
        ),
        SizedBox(height: 8 * widget.spacingMultiplier),
        SizedBox(
          height: 70 * widget.spacingMultiplier,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscure && !_showPassword,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.keyboardType == TextInputType.phone
                ? [PhoneNumberFormatter()]
                : null,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
            onChanged: (value) {
              // Auto-save form data on change
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  // We can save here if needed, but for performance
                  // we'll save only on continue tap
                }
              });
            },
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: AppTextStyles.bodyLarge.copyWith(
                fontSize: 18,
                color: AppColors.textHint,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 18 * widget.spacingMultiplier,
                vertical: 17 * widget.spacingMultiplier,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.border,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              suffixIcon: widget.obscure
                  ? GestureDetector(
                      onTap: () => setState(() => _showPassword = !_showPassword),
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textHint,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Foto KTP Card ────────────────────────────────────────────────────────────
class _FotoKtpCard extends StatelessWidget {
  const _FotoKtpCard({
    required this.isScanned,
    required this.onScanTap,
    required this.spacingMultiplier,
  });

  final bool isScanned;
  final VoidCallback? onScanTap;
  final double spacingMultiplier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isScanned ? AppColors.credit : AppColors.border,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(18 * spacingMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Foto KTP',
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4 * spacingMultiplier),
          // Subtitle
          Text(
            'Please ensure the text and photo are\nclearly visible without glare.',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16 * spacingMultiplier),
          // Scan button or success state
          if (isScanned)
            _KtpScannedSuccess(spacingMultiplier: spacingMultiplier)
          else
            _ScanButton(
              onTap: onScanTap,
              spacingMultiplier: spacingMultiplier,
            ),
        ],
      ),
    );
  }
}

// ─── KTP Scanned Success State ────────────────────────────────────────────────
class _KtpScannedSuccess extends StatelessWidget {
  const _KtpScannedSuccess({required this.spacingMultiplier});

  final double spacingMultiplier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.creditLight,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * spacingMultiplier,
        vertical: 24 * spacingMultiplier,
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.credit,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(height: 16 * spacingMultiplier),
          Text(
            'KTP Scanned Successfully',
            style: AppTextStyles.h3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.credit,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Scan KTP Button (dashed border) ─────────────────────────────────────────
class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.onTap,
    required this.spacingMultiplier,
  });

  final VoidCallback? onTap;
  final double spacingMultiplier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.primary,
          strokeWidth: 2,
          dashWidth: 8,
          dashSpace: 6,
          radius: 12,
        ),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 180 * spacingMultiplier),
          decoration: BoxDecoration(
            color: const Color(0xFFDAE2FF),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 2 * spacingMultiplier,
            vertical: 36 * spacingMultiplier,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Camera icon in dark-blue circle
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              SizedBox(height: 16 * spacingMultiplier),
              Text(
                'Tap to scan KTP',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 20,
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

// ─── Dashed Border Painter ────────────────────────────────────────────────────
class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rr = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rr);
    final metric = path.computeMetrics().first;
    final total = metric.length;

    double distance = 0;
    bool draw = true;

    while (distance < total) {
      final step = draw ? dashWidth : dashSpace;
      if (draw) {
        canvas.drawPath(
          metric.extractPath(distance, math.min(distance + step, total)),
          paint,
        );
      }
      distance += step;
      draw = !draw;
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashWidth != dashWidth ||
      old.dashSpace != dashSpace ||
      old.radius != radius;
}

// ─── Continue Button ──────────────────────────────────────────────────────────
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.onTap,
    required this.isLoading,
    required this.buttonMultiplier,
  });

  final VoidCallback? onTap;
  final bool isLoading;
  final double buttonMultiplier;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap != null ? AppColors.primary : AppColors.textHint,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white12,
        child: SizedBox(
          width: double.infinity,
          height: 104 * buttonMultiplier,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
