import 'status_educando.dart';

/// Endereço residencial do educando, usado na ficha completa de perfil.
class Endereco {
  const Endereco({
    required this.rua,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.uf,
  });

  final String rua;
  final String bairro;
  final String cep;
  final String cidade;
  final String uf;
}

/// Resultado do teste de nivelamento de inglês aplicado na inscrição.
class TesteIngles {
  const TesteIngles({required this.nivel, required this.pontuacao, required this.data});

  final String nivel;
  final int pontuacao;
  final String data;
}

/// Curso anterior concluído pelo educando dentro do Instituto Eurofarma.
class CursoAnterior {
  const CursoAnterior({required this.nome, required this.ano, required this.situacao});

  final String nome;
  final int ano;
  final String situacao;
}

/// Evento de linha do tempo do educando (inscrição, início, módulos concluídos, etc).
class HistoricoEvento {
  const HistoricoEvento({required this.titulo, required this.data});

  final String titulo;
  final String data;
}

/// Linha do boletim: notas e faltas de uma disciplina em até dois semestres.
class Disciplina {
  const Disciplina({
    required this.nome,
    required this.presencas,
    this.cp1,
    this.gs1,
    this.md1,
    this.cp2,
    this.gs2,
    this.md2,
    required this.faltas,
    required this.frequenciaPercentual,
    this.mediaParcial,
  });

  final String nome;
  final String presencas;
  final double? cp1;
  final double? gs1;
  final double? md1;
  final double? cp2;
  final double? gs2;
  final double? md2;
  final int faltas;
  final double frequenciaPercentual;
  final double? mediaParcial;
}

/// Representa um educando (aluno) do Projeto Educandos do Instituto Eurofarma.
/// `status` e `frequencia` são mutáveis para refletir alterações feitas pelo
/// educador/administrador na tela de gestão do aluno (dado mockado, sem persistência real).
class Educando {
  Educando({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.nascimento,
    required this.idade,
    required this.curso,
    required this.progresso,
    required this.media,
    required this.iniciadoEm,
    required this.endereco,
    required this.linkedin,
    required this.curriculoArquivo,
    this.testeIngles,
    this.cursosAnteriores = const [],
    this.historico = const [],
    this.boletim = const [],
    required StatusEducando statusInicial,
    required int frequenciaInicial,
  })  : status = statusInicial,
        frequencia = frequenciaInicial;

  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String cpf;
  final String nascimento;
  final int idade;
  final String curso;
  final int progresso;
  final double media;
  final String iniciadoEm;
  final Endereco endereco;
  final String linkedin;
  final String curriculoArquivo;
  final TesteIngles? testeIngles;
  final List<CursoAnterior> cursosAnteriores;
  final List<HistoricoEvento> historico;
  final List<Disciplina> boletim;

  StatusEducando status;
  int frequencia;

  String get iniciais {
    final partes = nome.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (partes.length >= 2) {
      return (partes.first[0] + partes.last[0]).toUpperCase();
    }
    return (partes.isNotEmpty ? partes.first.substring(0, partes.first.length.clamp(0, 2)) : '?')
        .toUpperCase();
  }
}
