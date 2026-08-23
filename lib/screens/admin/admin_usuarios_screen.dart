import 'package:flutter/material.dart';

import '../../models/educador.dart';
import '../../theme/app_colors.dart';
import '../../widgets/initials_avatar.dart';

/// Gestão de usuários: lista de educadores/coordenadores com papel, turmas, último acesso e
/// ativação/desativação de conta (dado mockado, alterna o estado apenas em memória).
class AdminUsuariosScreen extends StatefulWidget {
  const AdminUsuariosScreen({super.key, required this.educadores});

  final List<Educador> educadores;

  @override
  State<AdminUsuariosScreen> createState() => _AdminUsuariosScreenState();
}

class _AdminUsuariosScreenState extends State<AdminUsuariosScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Governança', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Text('Gestão de usuários', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text(
          'Apenas administradores do Instituto Eurofarma podem alterar permissões.',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),
        Text('${widget.educadores.length} usuários cadastrados', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        for (final educador in widget.educadores) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InitialsAvatar(educador.iniciais),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(educador.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(educador.email, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(educador.papel.rotulo, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text('${educador.turmas} turmas', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(educador.ativo ? 'Ativo' : 'Inativo', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Switch(
                          value: educador.ativo,
                          activeTrackColor: AppColors.euroBlueDark,
                          onChanged: (v) => setState(() => educador.ativo = v),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ],
    );
  }
}
