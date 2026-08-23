import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/educando.dart';
import '../../models/status_educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_grid.dart';
import '../../widgets/stat_tile.dart';

/// Relatórios institucionais filtráveis por tipo (matrículas, frequência, conclusão/evasão,
/// motivos de desistência).
class AdminRelatoriosScreen extends StatefulWidget {
  const AdminRelatoriosScreen({super.key, required this.educandos});

  final List<Educando> educandos;

  @override
  State<AdminRelatoriosScreen> createState() => _AdminRelatoriosScreenState();
}

class _AdminRelatoriosScreenState extends State<AdminRelatoriosScreen> {
  String _tipoSelecionado = MockData.tiposRelatorio.first.titulo;

  @override
  Widget build(BuildContext context) {
    final educandos = widget.educandos;
    final ativos = educandos.where((e) => e.status == StatusEducando.emCurso).length;
    final concluidos = educandos.where((e) => e.status == StatusEducando.concluido).length;
    final desistentes = educandos.where((e) => e.status == StatusEducando.desistente).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Inteligência institucional', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Text('Relatórios', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('Filtre por tipo de relatório. Semestre ${MockData.semestreVigente}.',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: MockData.tiposRelatorio.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final tipo = MockData.tiposRelatorio[i];
              final selecionado = tipo.titulo == _tipoSelecionado;
              return ChoiceChip(
                label: Text(tipo.titulo),
                selected: selecionado,
                onSelected: (_) => setState(() => _tipoSelecionado = tipo.titulo),
                selectedColor: AppColors.euroBlueDark,
                labelStyle: TextStyle(color: selecionado ? Colors.white : AppColors.textSecondary, fontSize: 13),
                backgroundColor: AppColors.euroBlueSurface,
                side: BorderSide.none,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        StatGrid(
          crossAxisCount: 4,
          spacing: 8,
          children: [
            StatTile(label: 'No filtro', value: '${educandos.length}'),
            StatTile(label: 'Ativos', value: '$ativos'),
            StatTile(label: 'Concluídos', value: '$concluidos'),
            StatTile(label: 'Desistentes', value: '$desistentes'),
          ],
        ),
        const SizedBox(height: 16),
        _buildRelatorio(context),
      ],
    );
  }

  Widget _buildRelatorio(BuildContext context) {
    switch (_tipoSelecionado) {
      case 'Frequência por educando':
        final ordenados = [...widget.educandos]..sort((a, b) => b.frequencia.compareTo(a.frequencia));
        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(titulo: 'Frequência por educando', subtitulo: 'Ranking de presença individual'),
              const SizedBox(height: 12),
              for (final e in ordenados)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(e.nome)),
                      Text('${e.frequencia}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ],
          ),
        );
      case 'Conclusão & evasão':
        final concluidos = widget.educandos.where((e) => e.status == StatusEducando.concluido).length;
        final desistentes = widget.educandos.where((e) => e.status == StatusEducando.desistente).length;
        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(titulo: 'Conclusão & evasão', subtitulo: 'Comparativo do período'),
              const SizedBox(height: 12),
              Text('Concluídos: $concluidos'),
              Text('Desistentes: $desistentes'),
            ],
          ),
        );
      case 'Motivos de desistência':
        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(titulo: 'Motivos de desistência'),
              const SizedBox(height: 12),
              Text(MockData.motivoDesistencia, style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        );
      default:
        final porCurso = <String, int>{};
        for (final e in widget.educandos) {
          porCurso[e.curso] = (porCurso[e.curso] ?? 0) + 1;
        }
        final maxCurso = porCurso.values.isEmpty ? 1 : porCurso.values.reduce((a, b) => a > b ? a : b);
        return SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(titulo: 'Matrículas por curso', subtitulo: 'Distribuição atual da base por curso ofertado'),
              const SizedBox(height: 12),
              for (final entry in porCurso.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(entry.key), Text('${entry.value}', style: const TextStyle(fontWeight: FontWeight.bold))],
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
        );
    }
  }
}
