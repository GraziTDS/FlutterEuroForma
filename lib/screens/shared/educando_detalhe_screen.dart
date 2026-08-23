import 'package:flutter/material.dart';

import '../../models/educando.dart';
import '../../models/status_educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/labeled_progress_bar.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/success_banner.dart';
import '../educando/perfil_sections.dart';

/// Ficha do educando com o card "Gestão do aluno" editável — usada pelo Educador e pelo
/// Administrador ao tocar em um item da lista. Permite alterar status e frequência (dado
/// mockado, sem persistência) e reaproveita as seções somente-leitura da ficha do educando.
class EducandoDetalheScreen extends StatelessWidget {
  const EducandoDetalheScreen({
    super.key,
    required this.educando,
    required this.onSalvar,
  });

  final Educando educando;
  final void Function(StatusEducando status, int frequencia) onSalvar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(educando.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PerfilHeroCard(educando),
          const SizedBox(height: 16),
          _GestaoDoAlunoCard(educando: educando, onSalvar: onSalvar),
          const SizedBox(height: 16),
          DadosPessoaisCard(educando),
          const SizedBox(height: 16),
          EnderecoCard(educando),
          const SizedBox(height: 16),
          CurriculoETesteCard(educando),
          if (educando.cursosAnteriores.isNotEmpty) ...[
            const SizedBox(height: 16),
            CursosAnterioresCard(educando),
          ],
          const SizedBox(height: 16),
          HistoricoCard(educando),
        ],
      ),
    );
  }
}

class _GestaoDoAlunoCard extends StatefulWidget {
  const _GestaoDoAlunoCard({required this.educando, required this.onSalvar});

  final Educando educando;
  final void Function(StatusEducando status, int frequencia) onSalvar;

  @override
  State<_GestaoDoAlunoCard> createState() => _GestaoDoAlunoCardState();
}

class _GestaoDoAlunoCardState extends State<_GestaoDoAlunoCard> {
  late StatusEducando _status = widget.educando.status;
  late double _frequencia = widget.educando.frequencia.toDouble();
  bool _salvo = false;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Gestão do aluno'),
          const SizedBox(height: 14),
          const Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<StatusEducando>(
            initialValue: _status,
            items: StatusEducando.values.map((s) => DropdownMenuItem(value: s, child: Text(s.rotulo))).toList(),
            onChanged: (v) {
              if (v == null) return;
              setState(() {
                _status = v;
                _salvo = false;
              });
            },
          ),
          const SizedBox(height: 8),
          StatusChipWidget(status: _status),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Frequência', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('${_frequencia.toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: _frequencia,
            min: 0,
            max: 100,
            activeColor: AppColors.euroBlueDark,
            onChanged: (v) => setState(() {
              _frequencia = v;
              _salvo = false;
            }),
          ),
          const SizedBox(height: 6),
          LabeledProgressBar(label: 'Progresso do curso', percent: widget.educando.progresso),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: AppColors.euroBlueDark),
              onPressed: () {
                widget.onSalvar(_status, _frequencia.toInt());
                setState(() => _salvo = true);
              },
              icon: const Icon(Icons.save),
              label: const Text('Salvar alterações'),
            ),
          ),
          if (_salvo) ...[
            const SizedBox(height: 10),
            const SuccessBanner('Alterações registradas com auditoria.'),
          ],
        ],
      ),
    );
  }
}
