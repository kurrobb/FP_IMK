import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../main.dart';
import 'package:fp_imk/services/auth_service.dart';
import '../services/accessibility_provider.dart';
import '../widgets/accessible_button.dart';

class BiometricLoginScreen extends StatelessWidget {
  const BiometricLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final buttonScale = accessibilityProvider.getButtonSizeMultiplier();
        final spacingScale = accessibilityProvider.getSpacingMultiplier();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * spacingScale),
              child: Column(
                children: [
                  SizedBox(height: 48 * spacingScale),
                  const Text(
                    'FlexiBank',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8 * spacingScale),
                  const Text(
                    'Welcome back, Alex',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),

                  // Fingerprint button - scales with accessibility settings
                  Semantics(
                    label: 'Tap to scan fingerprint',
                    button: true,
                    child: GestureDetector(
                      onTap: () {
                        AuthService.login();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MainShell()),
                          (route) => false,
                        );
                      },
                      child: Container(
                        width: 140 * buttonScale,
                        height: 140 * buttonScale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              blurRadius: 32,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.fingerprint_rounded,
                          size: 72 * buttonScale,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28 * spacingScale),
                  const Text(
                    'Tap to scan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8 * spacingScale),
                  const Text(
                    'Use your fingerprint or Face ID\nfor secure, fast access.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),

                  // Use Password button
                  AccessibleElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Use Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * spacingScale),

                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Need help logging in?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 32 * spacingScale),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
