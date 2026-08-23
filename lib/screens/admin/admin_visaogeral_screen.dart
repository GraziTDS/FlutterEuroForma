import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/educador.dart';
import '../../models/educando.dart';
import '../../models/status_educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/distribuicao_status_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_grid.dart';
import '../../widgets/stat_tile.dart';

/// Painel executivo do Administrador: indicadores institucionais consolidados de todos os
/// educandos e educadores do Projeto Educandos.
class AdminVisaoGeralScreen extends StatelessWidget {
  const AdminVisaoGeralScreen({super.key, required this.educandos, required this.educadores});

  final List<Educando> educandos;
  final List<Educador> educadores;

  @override
  Widget build(BuildContext context) {
    final ativos = educandos.where((e) => e.status == StatusEducando.emCurso).length;
    final concluidos = educandos.where((e) => e.status == StatusEducando.concluido).length;
    final taxa = educandos.isEmpty ? 0 : (concluidos * 100 ~/ educandos.length);
    final presencaMedia = educandos.isEmpty ? 0 : (educandos.map((e) => e.frequencia).reduce((a, b) => a + b) / educandos.length).round();
    final educadoresAtivos = educadores.where((e) => e.ativo).length;

    final porCurso = <String, int>{};
    for (final e in educandos) {
      porCurso[e.curso] = (porCurso[e.curso] ?? 0) + 1;
    }
    final maxCurso = porCurso.values.isEmpty ? 1 : porCurso.values.reduce((a, b) => a > b ? a : b);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Painel executivo', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Text('Visão consolidada', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text(
          'Indicadores institucionais — Instituto Eurofarma · Projeto Educandos · Semestre ${MockData.semestreVigente}',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        StatGrid(
          children: [
            StatTile(label: 'Total de educandos', value: '${educandos.length}', icon: Icons.groups),
            StatTile(label: 'Ativos', value: '$ativos', icon: Icons.person),
            StatTile(label: 'Presença média', value: '$presencaMedia%', icon: Icons.how_to_reg),
            StatTile(label: 'Taxa de conclusão', value: '$taxa%', icon: Icons.trending_up),
            StatTile(label: 'Concluídos', value: '$concluidos', icon: Icons.school),
            StatTile(label: 'Educadores ativos', value: '$educadoresAtivos/${educadores.length}', icon: Icons.groups),
          ],
        ),
        const SizedBox(height: 16),
        DistribuicaoStatusCard(educandos: educandos),
        const SizedBox(height: 16),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(titulo: 'Educandos por curso', subtitulo: 'Distribuição atual da base por curso ofertado'),
              const SizedBox(height: 12),
              for (final entry in porCurso.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key),
                          Text('${entry.value}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: LinearProgressIndicator(
                          value: entry.value / maxCurso,
                          minHeight: 8,
                          backgroundColor: AppColors.neutralBorder,
                          valueColor: const AlwaysStoppedAnimation(AppColors.euroBlue),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
