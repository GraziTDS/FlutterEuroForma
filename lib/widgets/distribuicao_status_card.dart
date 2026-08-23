import 'package:flutter/material.dart';

import '../models/educando.dart';
import '../models/status_educando.dart';
import '../theme/app_colors.dart';
import 'section_card.dart';
import 'section_header.dart';
import 'status_chip.dart';

/// Card "Distribuição por status": conta quantos educandos estão em cada [StatusEducando] e
/// desenha uma barra proporcional para cada um. Reaproveitado pelo Dashboard do Educador e
/// pela Visão geral do Administrador.
class DistribuicaoStatusCard extends StatelessWidget {
  const DistribuicaoStatusCard({super.key, required this.educandos});

  final List<Educando> educandos;

  @override
  Widget build(BuildContext context) {
    final total = educandos.isEmpty ? 1 : educandos.length;
    final itens = [
      (StatusEducando.emCurso, AppColors.statusEmCurso, educandos.where((e) => e.status == StatusEducando.emCurso).length),
      (StatusEducando.concluido, AppColors.statusConcluido, educandos.where((e) => e.status == StatusEducando.concluido).length),
      (StatusEducando.inscrito, AppColors.statusInscrito, educandos.where((e) => e.status == StatusEducando.inscrito).length),
      (StatusEducando.desistente, AppColors.statusDesistente, educandos.where((e) => e.status == StatusEducando.desistente).length),
    ];

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Distribuição por status'),
          const SizedBox(height: 12),
          for (final (status, cor, qtd) in itens) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusChipWidget(status: status),
                      Text('$qtd · ${qtd * 100 ~/ total}%', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      value: qtd / total,
                      minHeight: 6,
                      backgroundColor: AppColors.neutralBorder,
                      valueColor: AlwaysStoppedAnimation(cor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
