import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../widgets/accessible_button.dart';

class QrisScreen extends StatefulWidget {
  const QrisScreen({super.key});

  @override
  State<QrisScreen> createState() => _QrisScreenState();
}

class _QrisScreenState extends State<QrisScreen>
    with SingleTickerProviderStateMixin {
  bool _torchOn = false;
  late AnimationController _scanController;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanAnim =
        Tween<double>(begin: 0.1, end: 0.9).animate(_scanController);
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
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
            padding: EdgeInsets.all(20 * spacingScale),
            child: Column(
              children: [
                SizedBox(height: 8 * spacingScale),
                const Text(
                  'Position the QR code inside the\nframe to pay or transfer instantly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20 * spacingScale),

                // Scanner frame
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300 * buttonScale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          // Corner brackets
                          ..._corners(),

                          // QR placeholder icon
                          Center(
                            child: Icon(
                              Icons.qr_code_2_rounded,
                              size: 80 * buttonScale,
                              color: Colors.black.withValues(alpha: 0.15),
                            ),
                          ),

                          // Scan line
                          AnimatedBuilder(
                            animation: _scanAnim,
                            builder: (_, _) => Positioned(
                              top: _scanAnim.value * 280 * buttonScale,
                              left: 24,
                              right: 24,
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Colors.transparent,
                                    AppColors.primary,
                                    Colors.transparent,
                                  ]),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),

                          // Torch button - scales with accessibility
                          Positioned(
                            bottom: 16 * spacingScale,
                            right: 16 * spacingScale,
                            child: Semantics(
                              label: _torchOn ? 'Turn off torch' : 'Turn on torch',
                              button: true,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _torchOn = !_torchOn),
                                child: Container(
                                  width: 44 * buttonScale,
                                  height: 44 * buttonScale,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.12),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    _torchOn
                                        ? Icons.flashlight_on_rounded
                                        : Icons.flashlight_off_rounded,
                                    color: AppColors.textPrimary,
                                    size: 22 * buttonScale,
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
                SizedBox(height: 20 * spacingScale),

                // Upload button
                AccessibleElevatedButton(
                  onPressed: () {},
                  icon: Icons.image_outlined,
                  child: const Text(
                    'Upload from Gallery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16 * spacingScale),

                // Supported standards
                Container(
                  padding: EdgeInsets.all(16 * spacingScale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.info_outline_rounded,
                          color: AppColors.primary, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Supported Standards',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Accepts all national standard QRIS codes for merchants and personal transfers.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
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

  List<Widget> _corners() {
    const size = 28.0;
    const thickness = 3.0;
    const color = AppColors.primary;
    const r = 4.0;
    return [
      // TL
      Positioned(
          top: 16, left: 16,
          child: _corner(size, thickness, color, r, top: true, left: true)),
      // TR
      Positioned(
          top: 16, right: 16,
          child: _corner(size, thickness, color, r, top: true, left: false)),
      // BL
      Positioned(
          bottom: 16, left: 16,
          child: _corner(size, thickness, color, r, top: false, left: true)),
      // BR
      Positioned(
          bottom: 16, right: 16,
          child: _corner(size, thickness, color, r, top: false, left: false)),
    ];
  }

  Widget _corner(double s, double t, Color c, double r,
      {required bool top, required bool left}) {
    return CustomPaint(
      size: Size(s, s),
      painter: _CornerPainter(t, c, r, top: top, left: left),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final double thickness;
  final Color color;
  final double radius;
  final bool top;
  final bool left;

  const _CornerPainter(this.thickness, this.color, this.radius,
      {required this.top, required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    if (top && left) {
      path.moveTo(0, h);
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
      path.lineTo(w, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(w - radius, 0);
      path.arcToPoint(Offset(w, radius), radius: Radius.circular(radius));
      path.lineTo(w, h);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, h - radius);
      path.arcToPoint(Offset(radius, h), radius: Radius.circular(radius));
      path.lineTo(w, h);
    } else {
      path.moveTo(0, h);
      path.lineTo(w - radius, h);
      path.arcToPoint(Offset(w, h - radius), radius: Radius.circular(radius));
      path.lineTo(w, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
