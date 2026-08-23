import 'package:flutter/material.dart';

import '../../models/perfil.dart';
import '../../theme/app_colors.dart';

/// Tela de login - ponto de entrada único da plataforma. O usuário escolhe o perfil de
/// acesso (Educando, Educador ou Administrador) e informa e-mail/senha. Como não há backend
/// nesta Sprint, qualquer combinação de credenciais preenchidas autentica no perfil
/// selecionado (dado mockado).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onEntrar});

  final ValueChanged<Perfil> onEntrar;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Perfil _perfilSelecionado = Perfil.educando;
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController(text: '••••••••');
  bool _senhaVisivel = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Hero(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bem-vindo(a)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text(
                        'Selecione seu perfil e acesse a plataforma.',
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      _PerfilSeletor(
                        selecionado: _perfilSelecionado,
                        onSelecionar: (p) => setState(() => _perfilSelecionado = p),
                      ),
                      const SizedBox(height: 20),
                      const Text('E-mail', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'seu.email@eurofarma.com.br',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Senha', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Text('Esqueci minha senha', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _senhaController,
                        obscureText: !_senhaVisivel,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_senhaVisivel ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.euroBlueDark,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => widget.onEntrar(_perfilSelecionado),
                          child: Text('Entrar como ${_perfilSelecionado.rotulo}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield, size: 16, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Acesso protegido. Autenticação mockada nesta Sprint (sem Firebase/backend).',
                              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.euroBlueDark, AppColors.euroBlue],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(9)),
                alignment: Alignment.center,
                child: const Icon(Icons.menu_book, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('euroForma', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('INSTITUTO EUROFARMA', style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 0.5)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Sua vida move a nossa.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          ),
          const SizedBox(height: 10),
          const Text(
            'O Projeto Educandos do Instituto Eurofarma promove capacitação e desenvolvimento '
            'para pessoas em situação de vulnerabilidade social. Acompanhe turmas, notas, '
            'frequência e oportunidades em um só lugar.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _HeroChip(valor: '+700', legenda: 'educandos por semestre'),
              const SizedBox(width: 10),
              _HeroChip(valor: '4', legenda: 'cursos ativos'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.valor, required this.legenda});

  final String valor;
  final String legenda;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(valor, style: const TextStyle(color: AppColors.euroGold, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(legenda, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }
}

class _PerfilSeletor extends StatelessWidget {
  const _PerfilSeletor({required this.selecionado, required this.onSelecionar});

  final Perfil selecionado;
  final ValueChanged<Perfil> onSelecionar;

  static const _icones = {
    Perfil.educando: Icons.menu_book,
    Perfil.educador: Icons.groups,
    Perfil.administrador: Icons.admin_panel_settings,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Perfil.values
          .map(
            (perfil) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: perfil == Perfil.values.last ? 0 : 8),
                child: _PerfilOpcao(
                  perfil: perfil,
                  icone: _icones[perfil]!,
                  ativo: perfil == selecionado,
                  onTap: () => onSelecionar(perfil),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PerfilOpcao extends StatelessWidget {
  const _PerfilOpcao({required this.perfil, required this.icone, required this.ativo, required this.onTap});

  final Perfil perfil;
  final IconData icone;
  final bool ativo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cor = ativo ? AppColors.euroBlue : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: ativo ? AppColors.euroBlueSurface : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ativo ? AppColors.euroBlue : AppColors.neutralBorder),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icone, size: 20, color: cor),
            const SizedBox(height: 4),
            Text(
              perfil.rotulo,
              textAlign: TextAlign.center,
              style: TextStyle(color: cor, fontSize: 12, fontWeight: ativo ? FontWeight.w600 : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
