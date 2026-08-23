import 'package:flutter/material.dart';

import '../../data/app_scope.dart';
import '../../models/perfil.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_top_bar.dart';
import '../educando/educando_home_screen.dart';
import '../educando/educando_perfil_screen.dart';

/// Shell de navegação do perfil Educando: barra superior + abas "Início" e "Meu perfil".
class EducandoShell extends StatefulWidget {
  const EducandoShell({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<EducandoShell> createState() => _EducandoShellState();
}

class _EducandoShellState extends State<EducandoShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final educando = appState.educandoLogado;

    final telas = [
      EducandoHomeScreen(educando: educando, onVerPerfil: () => setState(() => _index = 1)),
      EducandoPerfilScreen(educando: educando),
    ];

    return Scaffold(
      appBar: AppTopBar(
        perfil: Perfil.educando,
        nomeUsuario: '${educando.nome} · ${educando.email}',
        onLogout: widget.onLogout,
      ),
      body: IndexedStack(index: _index, children: telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.euroBlueSurface,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: AppColors.euroBlue), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: AppColors.euroBlue), label: 'Meu perfil'),
        ],
      ),
    );
  }
}
