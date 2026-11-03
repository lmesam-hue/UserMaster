import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final double overlayOpacity;

  const AppBackground({
    super.key,
    required this.child,
    this.imagePath = 'assets/images/background.jpg',
    this.overlayOpacity = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: overlayOpacity * 0.5),
              AppColors.primary.withValues(alpha: overlayOpacity),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}