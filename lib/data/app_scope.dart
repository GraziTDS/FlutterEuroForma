import 'package:flutter/widgets.dart';

import 'app_state.dart';

/// Disponibiliza o [AppState] para toda a árvore de widgets sem depender de pacotes
/// externos de gerência de estado (equivalente ao `viewModel()` usado no lado Kotlin).
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState appState, required super.child}) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope não encontrado na árvore de widgets.');
    return scope!.notifier!;
  }
}
