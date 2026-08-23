/// Perfis de acesso suportados pela plataforma euroForma.
/// Cada perfil enxerga um conjunto diferente de telas e funcionalidades.
enum Perfil {
  educando('Educando'),
  educador('Educador'),
  administrador('Administrador');

  const Perfil(this.rotulo);
  final String rotulo;
}
