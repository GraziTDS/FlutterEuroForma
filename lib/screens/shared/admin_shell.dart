import 'package:flutter/material.dart';

import '../../data/app_scope.dart';
import '../../data/mock_data.dart';
import '../../models/perfil.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_top_bar.dart';
import '../admin/admin_relatorios_screen.dart';
import '../admin/admin_usuarios_screen.dart';
import '../admin/admin_visaogeral_screen.dart';
import '../educador/educador_educandos_screen.dart';
import 'educando_detalhe_route.dart';

/// Shell de navegação do perfil Administrador: barra superior + abas Visão geral, Usuários,
/// Educandos e Relatórios.
class AdminShell extends StatefulWidget {
  const AdminShell({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;
  final _educadores = MockData.educadores();

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);

    final telas = [
      AdminVisaoGeralScreen(educandos: appState.educandos, educadores: _educadores),
      AdminUsuariosScreen(educadores: _educadores),
      EducadorEducandosScreen(
        educandos: appState.educandos,
        titulo: 'Educandos',
        onVerDetalhe: (id) => abrirDetalheEducando(context, id),
      ),
      AdminRelatoriosScreen(educandos: appState.educandos),
    ];

    return Scaffold(
      appBar: AppTopBar(
        perfil: Perfil.administrador,
        nomeUsuario: '${MockData.administrador.nome} · ${MockData.administrador.email}',
        onLogout: widget.onLogout,
      ),
      body: IndexedStack(index: _index, children: telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.euroBlueSurface,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.shield_outlined), selectedIcon: Icon(Icons.shield, color: AppColors.euroBlue), label: 'Visão geral'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups, color: AppColors.euroBlue), label: 'Usuários'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people, color: AppColors.euroBlue), label: 'Educandos'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart, color: AppColors.euroBlue), label: 'Relatórios'),
        ],
      ),
    );
  }
}
