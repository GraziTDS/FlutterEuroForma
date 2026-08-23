import 'package:flutter/material.dart';

import '../../models/educando.dart';
import '../../theme/app_colors.dart';
import '../../widgets/initials_avatar.dart';
import '../../widgets/section_card.dart';
import '../../widgets/section_header.dart';

/// Seções somente-leitura da ficha do educando, reaproveitadas tanto pela tela de perfil do
/// próprio educando quanto pela tela de gestão do Educador/Administrador ([EducandoDetalheScreen]).

class PerfilHeroCard extends StatelessWidget {
  const PerfilHeroCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [AppColors.euroBlueDark, AppColors.euroBlue]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InitialsAvatar(
            educando.iniciais,
            size: 56,
            background: Colors.white.withValues(alpha: 0.18),
            foreground: Colors.white,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(educando.nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Text(
                  '${educando.curso}${educando.idade > 0 ? ' · ${educando.idade} anos' : ''}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CampoInfo extends StatelessWidget {
  const _CampoInfo(this.label, this.valor);

  final String label;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(valor, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class DadosPessoaisCard extends StatelessWidget {
  const DadosPessoaisCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Dados pessoais'),
          const SizedBox(height: 12),
          Row(children: [_CampoInfo('E-mail', educando.email), const SizedBox(width: 16), _CampoInfo('Telefone', educando.telefone)]),
          const SizedBox(height: 12),
          Row(children: [_CampoInfo('CPF', educando.cpf), const SizedBox(width: 16), _CampoInfo('Nascimento', educando.nascimento)]),
          const SizedBox(height: 12),
          Row(children: [_CampoInfo('Curso atual', educando.curso), const SizedBox(width: 16), _CampoInfo('LinkedIn', educando.linkedin)]),
        ],
      ),
    );
  }
}

class EnderecoCard extends StatelessWidget {
  const EnderecoCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Endereço'),
          const SizedBox(height: 12),
          Row(children: [_CampoInfo('Rua', educando.endereco.rua), const SizedBox(width: 16), _CampoInfo('Bairro', educando.endereco.bairro)]),
          const SizedBox(height: 12),
          Row(children: [
            _CampoInfo('Cidade', '${educando.endereco.cidade} - ${educando.endereco.uf}'),
            const SizedBox(width: 16),
            _CampoInfo('CEP', educando.endereco.cep),
          ]),
        ],
      ),
    );
  }
}

class CurriculoETesteCard extends StatelessWidget {
  const CurriculoETesteCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    final teste = educando.testeIngles;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Currículo'),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.description, size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(educando.curriculoArquivo, style: const TextStyle(fontSize: 14)),
            ],
          ),
          if (teste != null) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const SectionHeader(titulo: 'Teste de Inglês'),
            const SizedBox(height: 10),
            Row(children: [
              _CampoInfo('Nível', teste.nivel),
              const SizedBox(width: 16),
              _CampoInfo('Pontuação', '${teste.pontuacao}/100'),
              const SizedBox(width: 16),
              _CampoInfo('Data', teste.data),
            ]),
          ],
        ],
      ),
    );
  }
}

class CursosAnterioresCard extends StatelessWidget {
  const CursosAnterioresCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Histórico de cursos anteriores'),
          const SizedBox(height: 12),
          for (final curso in educando.cursosAnteriores)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(curso.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text('Ano: ${curso.ano}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.euroBlueSurface, borderRadius: BorderRadius.circular(50)),
                    child: Text(curso.situacao, style: const TextStyle(fontSize: 11, color: AppColors.euroBlue)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class HistoricoCard extends StatelessWidget {
  const HistoricoCard(this.educando, {super.key});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titulo: 'Histórico do educando'),
          const SizedBox(height: 14),
          for (final evento in educando.historico)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(evento.titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(evento.data, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
