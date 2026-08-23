import 'package:flutter/material.dart';

import 'data/app_scope.dart';
import 'data/app_state.dart';
import 'models/perfil.dart';
import 'screens/login/login_screen.dart';
import 'screens/shared/admin_shell.dart';
import 'screens/shared/educador_shell.dart';
import 'screens/shared/educando_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EuroFormaApp());
}

/// Widget raiz do app: fornece o [AppState] compartilhado e alterna entre a tela de Login e
/// o shell de navegação do perfil autenticado (Educando, Educador ou Administrador).
class EuroFormaApp extends StatefulWidget {
  const EuroFormaApp({super.key});

  @override
  State<EuroFormaApp> createState() => _EuroFormaAppState();
}

class _EuroFormaAppState extends State<EuroFormaApp> {
  final _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      appState: _appState,
      child: MaterialApp(
        title: 'euroForma',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: AnimatedBuilder(
          animation: _appState,
          builder: (context, _) {
            final perfil = _appState.perfilLogado;
            if (perfil == null) {
              return LoginScreen(onEntrar: _appState.login);
            }
            return switch (perfil) {
              Perfil.educando => EducandoShell(onLogout: _appState.logout),
              Perfil.educador => EducadorShell(onLogout: _appState.logout),
              Perfil.administrador => AdminShell(onLogout: _appState.logout),
            };
          },
        ),
      ),
    );
  }
}
