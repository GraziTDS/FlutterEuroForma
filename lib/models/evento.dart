import 'tipo_evento.dart';

/// Evento de agenda (workshop, palestra, mentoria ou networking) disponível para inscrição
/// do educando. `vagasOcupadas` e `inscrito` são mutáveis para simular a inscrição em tempo real.
class Evento {
  Evento({
    required this.id,
    required this.tipo,
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.data,
    required this.vagasTotal,
    required int vagasOcupadasInicial,
    bool inscritoInicial = false,
  })  : vagasOcupadas = vagasOcupadasInicial,
        inscrito = inscritoInicial;

  final String id;
  final TipoEvento tipo;
  final String titulo;
  final String descricao;
  final String local;
  final String data;
  final int vagasTotal;

  int vagasOcupadas;
  bool inscrito;

  int get percentualOcupado => vagasTotal == 0 ? 0 : (vagasOcupadas * 100 ~/ vagasTotal);
}

/// Aula futura prevista na agenda do educando.
class AulaProxima {
  const AulaProxima({
    required this.disciplina,
    required this.diaMes,
    required this.mesAbreviado,
    required this.dataCompleta,
  });

  final String disciplina;
  final String diaMes;
  final String mesAbreviado;
  final String dataCompleta;
}
