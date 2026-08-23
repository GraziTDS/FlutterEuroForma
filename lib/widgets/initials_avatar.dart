import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Avatar circular com iniciais, usado em listas de educandos e educadores.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.iniciais, {super.key, this.size = 40, this.background, this.foreground});

  final String iniciais;
  final double size;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background ?? AppColors.euroBlueSurface,
        shape: BoxShape.circle,
      ),
      child: Text(
        iniciais,
        style: TextStyle(
          color: foreground ?? AppColors.euroBlue,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}
