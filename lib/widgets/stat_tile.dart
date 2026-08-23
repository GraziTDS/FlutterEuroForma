import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Pequeno card de indicador numérico (usado nos painéis: frequência, média, total etc.).
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    this.caption,
    this.icon,
    this.accent = AppColors.euroBlue,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData? icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: accent),
              ),
              const SizedBox(height: 8),
            ],
            Text(label.toUpperCase(), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, letterSpacing: 0.3)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            if (caption != null) ...[
              const SizedBox(height: 2),
              Text(caption!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ],
        ),
      ),
    );
  }
}
