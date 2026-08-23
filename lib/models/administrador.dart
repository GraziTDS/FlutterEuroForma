/// Usuário com perfil de Administrador do Instituto Eurofarma (visão institucional consolidada).
class Administrador {
  const Administrador({required this.nome, required this.email});

  final String nome;
  final String email;
}

/// Card de tipo de relatório disponível na tela de Relatórios do Administrador.
class TipoRelatorio {
  const TipoRelatorio({required this.titulo, required this.descricao});

  final String titulo;
  final String descricao;
}
