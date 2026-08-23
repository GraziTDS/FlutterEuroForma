import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Barra de progresso horizontal com rótulo e percentual, no padrão "Progresso do curso".
class LabeledProgressBar extends StatelessWidget {
  const LabeledProgressBar({super.key, required this.label, required this.percent, this.color = AppColors.euroBlue});

  final String label;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            Text('$percent%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: LinearProgressIndicator(
            value: percent.clamp(0, 100) / 100,
            minHeight: 8,
            backgroundColor: AppColors.neutralBorder,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
