import 'package:flutter/material.dart';

import '../../data/app_scope.dart';
import 'educando_detalhe_screen.dart';

/// Abre a ficha de gestão do educando [id], passando o objeto correspondente como parâmetro
/// de navegação (equivalente à rota `educando/{id}` do lado Kotlin).
void abrirDetalheEducando(BuildContext context, String id) {
  final appState = AppScope.of(context);
  final educando = appState.educandoPorId(id);
  if (educando == null) return;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => EducandoDetalheScreen(
        educando: educando,
        onSalvar: (status, frequencia) {
          appState.atualizarStatus(id, status);
          appState.atualizarFrequencia(id, frequencia);
        },
      ),
    ),
  );
}
