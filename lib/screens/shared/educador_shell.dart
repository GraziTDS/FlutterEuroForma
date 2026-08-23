import 'package:flutter/material.dart';

import '../../data/app_scope.dart';
import '../../data/mock_data.dart';
import '../../models/perfil.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_top_bar.dart';
import '../educador/educador_cadastro_screen.dart';
import '../educador/educador_dashboard_screen.dart';
import '../educador/educador_educandos_screen.dart';
import 'educando_detalhe_route.dart';

/// Shell de navegação do perfil Educador: barra superior + abas Dashboard, Educandos e
/// Cadastrar.
class EducadorShell extends StatefulWidget {
  const EducadorShell({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<EducadorShell> createState() => _EducadorShellState();
}

class _EducadorShellState extends State<EducadorShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final educador = MockData.educadorLogado();

    final telas = [
      EducadorDashboardScreen(
        educandos: appState.educandos,
        onCadastrarEducando: () => setState(() => _index = 2),
        onVerTodos: () => setState(() => _index = 1),
        onVerDetalhe: (id) => abrirDetalheEducando(context, id),
      ),
      EducadorEducandosScreen(
        educandos: appState.educandos,
        onVerDetalhe: (id) => abrirDetalheEducando(context, id),
      ),
      EducadorCadastroScreen(
        cursos: MockData.cursosOferecidos,
        onCadastrar: (nome, cpf, telefone, email, curso) {
          appState.cadastrarEducando(nomeCompleto: nome, cpf: cpf, telefone: telefone, email: email, curso: curso);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appState.mensagemFeedback ?? 'Educando cadastrado com sucesso!')),
          );
          setState(() => _index = 1);
        },
      ),
    ];

    return Scaffold(
      appBar: AppTopBar(
        perfil: Perfil.educador,
        nomeUsuario: '${educador.nome} · ${educador.email}',
        onLogout: widget.onLogout,
      ),
      body: IndexedStack(index: _index, children: telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.euroBlueSurface,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard, color: AppColors.euroBlue), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups, color: AppColors.euroBlue), label: 'Educandos'),
          NavigationDestination(icon: Icon(Icons.person_add_alt_outlined), selectedIcon: Icon(Icons.person_add_alt, color: AppColors.euroBlue), label: 'Cadastrar'),
        ],
      ),
    );
  }
}
