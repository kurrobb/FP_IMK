import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AssistiveTouchMenu extends StatefulWidget {
  final bool isEnabled;
  final bool isVoiceEnabled;
  final Function()? onHome;
  final Function()? onSettings;
  final Function()? onTransfer;
  final Function()? onHistory;
  final Function()? onVoice;

  const AssistiveTouchMenu({
    super.key,
    required this.isEnabled,
    this.isVoiceEnabled = false,
    this.onHome,
    this.onSettings,
    this.onTransfer,
    this.onHistory,
    this.onVoice,
  });

  @override
  State<AssistiveTouchMenu> createState() => _AssistiveTouchMenuState();
}

class _AssistiveTouchMenuState extends State<AssistiveTouchMenu>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late Offset _position;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _position = const Offset(310, 620);
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
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
                  .clamp(0, MediaQuery.of(context).size.width - 60),
              (_position.dy + details.delta.dy)
                  .clamp(0, MediaQuery.of(context).size.height - 60),
            );
          });
        },
        child: Material(
          color: Colors.transparent,
          child: _isExpanded
              ? _buildExpandedMenu()
              : _buildCollapsedButton(),
        ),
      ),
    );
  }

  Widget _buildCollapsedButton() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.accessibility_new_rounded,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildExpandedMenu() {
    final items = <_MenuItemData>[
      _MenuItemData(Icons.home_rounded, 'Beranda', widget.onHome),
      _MenuItemData(Icons.swap_horiz_rounded, 'Transfer', widget.onTransfer),
      _MenuItemData(Icons.history_rounded, 'Riwayat', widget.onHistory),
      _MenuItemData(Icons.settings_rounded, 'Setelan', widget.onSettings),
      if (widget.isVoiceEnabled)
        _MenuItemData(Icons.mic_rounded, 'Suara', widget.onVoice,
            isAccent: true),
    ];

    return ScaleTransition(
      scale: _expandAnimation,
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Menu items
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildMenuItem(item),
              )),
          const SizedBox(height: 4),
          // Close button
          GestureDetector(
            onTap: _toggleExpanded,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(_MenuItemData item) {
    return GestureDetector(
      onTap: () {
        _toggleExpanded();
        item.onTap?.call();
      },
      child: Semantics(
        label: item.label,
        button: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: item.isAccent ? AppColors.tealDark : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Icon button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: item.isAccent
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.teal, AppColors.tealDark],
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primaryLight, AppColors.primary],
                      ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (item.isAccent ? AppColors.teal : AppColors.primary)
                        .withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(item.icon, color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isAccent;

  _MenuItemData(this.icon, this.label, this.onTap, {this.isAccent = false});
}