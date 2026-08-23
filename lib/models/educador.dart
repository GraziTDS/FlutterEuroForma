import 'papel_usuario.dart';

/// Educador/coordenador cadastrado na plataforma, responsável por acompanhar turmas de educandos.
class Educador {
  Educador({
    required this.id,
    required this.nome,
    required this.email,
    required this.papel,
    required this.turmas,
    required this.ultimoAcesso,
    required bool ativoInicial,
  }) : ativo = ativoInicial;

  final String id;
  final String nome;
  final String email;
  final PapelUsuario papel;
  final int turmas;
  final String ultimoAcesso;

  bool ativo;

  String get iniciais {
    final semTitulo = nome.replaceFirst('Prof. ', '').replaceFirst('Profa. ', '');
    final partes = semTitulo.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (partes.length >= 2) {
      return (partes.first[0] + partes.last[0]).toUpperCase();
    }
    return (partes.isNotEmpty ? partes.first.substring(0, partes.first.length.clamp(0, 2)) : '?')
        .toUpperCase();
  }
}
