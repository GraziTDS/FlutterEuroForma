import 'package:flutter/material.dart';

import '../models/status_educando.dart';
import '../theme/app_colors.dart';

/// Selo de status (Inscrito / Em curso / Concluído / Desistente) com cores semânticas.
class StatusChipWidget extends StatelessWidget {
  const StatusChipWidget({super.key, required this.status});

  final StatusEducando status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      StatusEducando.emCurso => (AppColors.euroBlueSurface, AppColors.statusEmCurso),
      StatusEducando.concluido => (AppColors.statusConcluido.withValues(alpha: 0.15), AppColors.statusConcluido),
      StatusEducando.inscrito => (AppColors.statusInscritoBg, AppColors.statusInscrito),
      StatusEducando.desistente => (AppColors.statusDesistenteBg, AppColors.statusDesistente),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(50)),
      child: Text(status.rotulo, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
