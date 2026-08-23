enum TipoEvento {
  workshop('Workshop'),
  palestra('Palestra'),
  mentoria('Mentoria'),
  networking('Networking');

  const TipoEvento(this.rotulo);
  final String rotulo;
}
