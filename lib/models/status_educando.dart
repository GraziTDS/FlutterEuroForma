/// Situação do educando dentro da jornada do curso.
enum StatusEducando {
  inscrito('Inscrito'),
  emCurso('Em curso'),
  concluido('Concluído'),
  desistente('Desistente');

  const StatusEducando(this.rotulo);
  final String rotulo;
}
