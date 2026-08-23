import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Título de seção com subtítulo opcional e ação à direita, no padrão "Título" usado no protótipo.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.titulo, this.subtitulo, this.trailing});

  final String titulo;
  final String? subtitulo;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              if (subtitulo != null) ...[
                const SizedBox(height: 2),
                Text(subtitulo!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
