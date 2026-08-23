import 'package:flutter/material.dart';

import '../models/perfil.dart';
import '../theme/app_colors.dart';

/// Barra superior padrão da aplicação: identidade euroForma + perfil ativo + nome do usuário
/// + sair. Presente em todas as telas autenticadas, reforçando em qual perfil o usuário está
/// navegando.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key, required this.perfil, required this.nomeUsuario, required this.onLogout});

  final Perfil perfil;
  final String nomeUsuario;
  final VoidCallback onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: AppColors.euroBlue, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text('e', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('euroForma', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(
                  nomeUsuario,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: AppColors.euroBlueSurface, borderRadius: BorderRadius.circular(50)),
          child: Text(perfil.rotulo, style: const TextStyle(color: AppColors.euroBlue, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: AppColors.textSecondary),
          tooltip: 'Sair',
          onPressed: onLogout,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
