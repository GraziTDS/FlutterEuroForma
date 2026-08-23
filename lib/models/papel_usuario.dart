/// Papel de acesso de um usuário da equipe (tela "Gestão de usuários" do Administrador).
enum PapelUsuario {
  coordenador('Coordenador'),
  educador('Educador');

  const PapelUsuario(this.rotulo);
  final String rotulo;
}
