import 'package:flutter/material.dart';

class AppIcon extends StatefulWidget {
  const AppIcon({
    super.key,
    required this.iconData,
    this.isDragged = false,
  });

  final IconData iconData;
  final bool isDragged;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool activateAnimation = _isHovered || widget.isDragged;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        constraints: BoxConstraints(minWidth: activateAnimation ? 54 : 48),
        height: activateAnimation ? 54 : 48,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors
              .primaries[widget.iconData.hashCode % Colors.primaries.length],
        ),
        child: AnimatedScale(
          scale: activateAnimation ? 1.25 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            widget.iconData,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
