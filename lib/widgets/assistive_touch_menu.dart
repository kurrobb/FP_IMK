import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AssistiveTouchMenu extends StatefulWidget {
  final bool isEnabled;
  final Function()? onVolumeUp;
  final Function()? onVolumeDown;
  final Function()? onHome;
  final Function()? onSettings;

  const AssistiveTouchMenu({
    super.key,
    required this.isEnabled,
    this.onVolumeUp,
    this.onVolumeDown,
    this.onHome,
    this.onSettings,
  });

  @override
  State<AssistiveTouchMenu> createState() => _AssistiveTouchMenuState();
}

class _AssistiveTouchMenuState extends State<AssistiveTouchMenu> {
  bool _isExpanded = false;
  late Offset _position;

  @override
  void initState() {
    super.initState();
    _position = const Offset(330, 650);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) return const SizedBox.shrink();

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position = Offset(
              (_position.dx + details.delta.dx)
                  .clamp(0, MediaQuery.of(context).size.width - 56),
              (_position.dy + details.delta.dy)
                  .clamp(0, MediaQuery.of(context).size.height - 56),
            );
          });
        },
        child: Material(
          color: Colors.transparent,
          child: _isExpanded ? _buildExpandedMenu() : _buildCollapsedButton(),
        ),
      ),
    );
  }

  Widget _buildCollapsedButton() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = true),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: const Icon(
          Icons.accessibility_new_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildExpandedMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _menuButton(
          icon: Icons.volume_up_rounded,
          label: 'Volume+',
          onTap: widget.onVolumeUp,
        ),
        const SizedBox(height: 8),
        _menuButton(
          icon: Icons.volume_down_rounded,
          label: 'Volume-',
          onTap: widget.onVolumeDown,
        ),
        const SizedBox(height: 8),
        _menuButton(
          icon: Icons.home_rounded,
          label: 'Home',
          onTap: widget.onHome,
        ),
        const SizedBox(height: 8),
        _menuButton(
          icon: Icons.settings_rounded,
          label: 'Settings',
          onTap: widget.onSettings,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = false),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Semantics(
        label: label,
        button: true,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
