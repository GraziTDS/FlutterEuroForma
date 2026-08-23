import 'package:flutter/material.dart';

import '../../models/educando.dart';
import '../../models/status_educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/distribuicao_status_card.dart';
import '../../widgets/initials_avatar.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_grid.dart';
import '../../widgets/stat_tile.dart';
import '../../widgets/status_chip.dart';

/// Dashboard do Educador: indicadores da turma (total de alunos, ativos, concluintes,
/// taxa de conclusão) e distribuição por status.
class EducadorDashboardScreen extends StatelessWidget {
  const EducadorDashboardScreen({
    super.key,
    required this.educandos,
    required this.onCadastrarEducando,
    required this.onVerTodos,
    required this.onVerDetalhe,
  });

  final List<Educando> educandos;
  final VoidCallback onCadastrarEducando;
  final VoidCallback onVerTodos;
  final ValueChanged<String> onVerDetalhe;

  @override
  Widget build(BuildContext context) {
    final ativos = educandos.where((e) => e.status == StatusEducando.emCurso).length;
    final concluintes = educandos.where((e) => e.status == StatusEducando.concluido).length;
    final taxa = educandos.isEmpty ? 0 : (concluintes * 100 ~/ educandos.length);
    final recentes = educandos.take(4).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Visão geral', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Text('Dashboard do Educador', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onCadastrarEducando,
            style: FilledButton.styleFrom(backgroundColor: AppColors.euroBlueDark, padding: const EdgeInsets.symmetric(vertical: 14)),
            icon: const Icon(Icons.person_add_alt),
            label: const Text('Cadastrar educando'),
          ),
        ),
        const SizedBox(height: 16),
        StatGrid(
          children: [
            StatTile(label: 'Total de alunos', value: '${educandos.length}', icon: Icons.groups),
            StatTile(label: 'Alunos ativos', value: '$ativos', icon: Icons.school),
            StatTile(label: 'Concluintes', value: '$concluintes', icon: Icons.school),
            StatTile(label: 'Taxa de conclusão', value: '$taxa%', icon: Icons.trending_up),
          ],
        ),
        const SizedBox(height: 16),
        DistribuicaoStatusCard(educandos: educandos),
        const SizedBox(height: 16),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                titulo: 'Educandos recentes',
                trailing: TextButton(
                  onPressed: onVerTodos,
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('Ver todos'), Icon(Icons.chevron_right, size: 18)]),
                ),
              ),
              const SizedBox(height: 8),
              for (final e in recentes)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: InitialsAvatar(e.iniciais),
                  title: Text(e.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(e.curso, style: const TextStyle(fontSize: 12)),
                  trailing: StatusChipWidget(status: e.status),
                  onTap: () => onVerDetalhe(e.id),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
