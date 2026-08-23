import 'package:flutter/material.dart';

import '../../data/app_scope.dart';
import '../../models/educando.dart';
import '../../models/evento.dart';
import '../../models/tipo_evento.dart';
import '../../theme/app_colors.dart';
import '../../widgets/labeled_progress_bar.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_grid.dart';
import '../../widgets/stat_tile.dart';

/// Painel inicial do educando: progresso do curso, frequência, média e boletim por disciplina,
/// próximas aulas e eventos disponíveis para inscrição.
class EducandoHomeScreen extends StatelessWidget {
  const EducandoHomeScreen({super.key, required this.educando, required this.onVerPerfil});

  final Educando educando;
  final VoidCallback onVerPerfil;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeroCard(educando: educando, onVerPerfil: onVerPerfil),
        const SizedBox(height: 16),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledProgressBar(label: 'Progresso do curso', percent: educando.progresso),
              const SizedBox(height: 16),
              StatGrid(
                children: [
                  StatTile(label: 'Frequência', value: '${educando.frequencia}%', icon: Icons.show_chart),
                  StatTile(label: 'Média', value: educando.media.toStringAsFixed(1), icon: Icons.military_tech),
                  StatTile(label: 'Status', value: educando.status.rotulo, icon: Icons.emoji_events),
                  StatTile(label: 'Iniciado em', value: educando.iniciadoEm, icon: Icons.calendar_today),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (educando.boletim.isNotEmpty) ...[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(titulo: 'Boletim — Notas e Faltas', subtitulo: 'Acompanhe suas notas, faltas e presenças por disciplina'),
                const SizedBox(height: 12),
                for (final disciplina in educando.boletim)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.euroBlueSurface, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(disciplina.nome, style: const TextStyle(fontWeight: FontWeight.w600))),
                            if (disciplina.mediaParcial != null)
                              Text('MP ${disciplina.mediaParcial!.toStringAsFixed(1)}',
                                  style: const TextStyle(color: AppColors.euroBlue, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(disciplina.presencas, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _MiniCampo('Faltas', '${disciplina.faltas}'),
                            _MiniCampo('Frequência', '${disciplina.frequenciaPercentual}%'),
                            if (disciplina.md1 != null) _MiniCampo('MD 1º sem.', disciplina.md1!.toStringAsFixed(1)),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        _ProximosEventosSection(),
      ],
    );
  }
}

class _MiniCampo extends StatelessWidget {
  const _MiniCampo(this.label, this.valor);

  final String label;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          Text(valor, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.educando, required this.onVerPerfil});

  final Educando educando;
  final VoidCallback onVerPerfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [AppColors.euroBlueDark, AppColors.euroBlue]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Olá,', style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text(educando.nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(50)),
            child: Text(educando.curso, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onVerPerfil,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            child: const Text('Ver meu perfil completo'),
          ),
        ],
      ),
    );
  }
}

class _ProximosEventosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final inscricoes = appState.eventos.where((e) => e.inscrito).length;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(titulo: 'Próximos eventos', subtitulo: '$inscricoes inscrição(ões) confirmada(s)'),
          const SizedBox(height: 12),
          for (final evento in appState.eventos) _EventoCard(evento: evento),
        ],
      ),
    );
  }
}

class _EventoCard extends StatelessWidget {
  const _EventoCard({required this.evento});

  final Evento evento;

  static const _icones = {
    TipoEvento.workshop: Icons.build,
    TipoEvento.palestra: Icons.campaign,
    TipoEvento.mentoria: Icons.groups,
    TipoEvento.networking: Icons.hub,
  };

  @override
  Widget build(BuildContext context) {
    final cheio = evento.vagasOcupadas >= evento.vagasTotal;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(border: Border.all(color: AppColors.neutralBorder), borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icones[evento.tipo], size: 16, color: AppColors.euroBlue),
              const SizedBox(width: 6),
              Text(evento.tipo.rotulo.toUpperCase(), style: const TextStyle(fontSize: 11, color: AppColors.euroBlue, fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(evento.data, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 6),
          Text(evento.titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(evento.descricao, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(evento.local, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ]),
          const SizedBox(height: 10),
          LabeledProgressBar(label: '${evento.vagasOcupadas}/${evento.vagasTotal} vagas', percent: evento.percentualOcupado),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: evento.inscrito || cheio ? null : () => AppScope.of(context).inscreverEmEvento(evento.id),
              style: FilledButton.styleFrom(backgroundColor: AppColors.euroBlueDark),
              child: Text(evento.inscrito ? 'Inscrição confirmada' : (cheio ? 'Vagas esgotadas' : 'Inscrever-se')),
            ),
          ),
        ],
      ),
    );
  }
}
