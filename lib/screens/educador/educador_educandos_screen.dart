import 'package:flutter/material.dart';

import '../../models/educando.dart';
import '../../models/status_educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/initials_avatar.dart';
import '../../widgets/labeled_progress_bar.dart';
import '../../widgets/status_chip.dart';

/// Listagem de educandos com busca por nome/curso e filtro por status. Reaproveitada pelo
/// Educador (turma própria) e pelo Administrador (escopo institucional), variando apenas o
/// [titulo] exibido.
class EducadorEducandosScreen extends StatefulWidget {
  const EducadorEducandosScreen({
    super.key,
    required this.educandos,
    required this.onVerDetalhe,
    this.titulo = 'Educandos',
  });

  final List<Educando> educandos;
  final ValueChanged<String> onVerDetalhe;
  final String titulo;

  @override
  State<EducadorEducandosScreen> createState() => _EducadorEducandosScreenState();
}

class _EducadorEducandosScreenState extends State<EducadorEducandosScreen> {
  String _busca = '';
  StatusEducando? _filtro;

  @override
  Widget build(BuildContext context) {
    final filtrados = widget.educandos.where((e) {
      final buscaOk = _busca.isEmpty ||
          e.nome.toLowerCase().contains(_busca.toLowerCase()) ||
          e.curso.toLowerCase().contains(_busca.toLowerCase());
      final statusOk = _filtro == null || e.status == _filtro;
      return buscaOk && statusOk;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Gestão', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              Text(widget.titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(hintText: 'Buscar por nome ou curso...', prefixIcon: Icon(Icons.search)),
                onChanged: (v) => setState(() => _busca = v),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FiltroChip(label: 'Todos os status', selecionado: _filtro == null, onTap: () => setState(() => _filtro = null)),
                    for (final s in StatusEducando.values)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _FiltroChip(label: s.rotulo, selecionado: _filtro == s, onTap: () => setState(() => _filtro = s)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('${filtrados.length} educando(s) encontrado(s)', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtrados.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final e = filtrados[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: InitialsAvatar(e.iniciais),
                title: Text(e.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.curso, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 6),
                      LabeledProgressBar(label: 'Frequência', percent: e.frequencia),
                    ],
                  ),
                ),
                isThreeLine: true,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusChipWidget(status: e.status),
                    const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                  ],
                ),
                onTap: () => widget.onVerDetalhe(e.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FiltroChip extends StatelessWidget {
  const _FiltroChip({required this.label, required this.selecionado, required this.onTap});

  final String label;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selecionado,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.euroBlueSurface,
      labelStyle: TextStyle(color: selecionado ? AppColors.euroBlue : AppColors.textSecondary, fontSize: 12),
      side: BorderSide(color: selecionado ? AppColors.euroBlue : AppColors.neutralBorder),
    );
  }
}
