import 'package:flutter/material.dart';

import '../../models/educando.dart';
import 'perfil_sections.dart';

/// Ficha completa do educando: dados pessoais, endereço, currículo, teste de inglês, cursos
/// anteriores e linha do tempo.
class EducandoPerfilScreen extends StatelessWidget {
  const EducandoPerfilScreen({super.key, required this.educando});

  final Educando educando;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PerfilHeroCard(educando),
        const SizedBox(height: 16),
        DadosPessoaisCard(educando),
        const SizedBox(height: 16),
        EnderecoCard(educando),
        const SizedBox(height: 16),
        CurriculoETesteCard(educando),
        if (educando.cursosAnteriores.isNotEmpty) ...[
          const SizedBox(height: 16),
          CursosAnterioresCard(educando),
        ],
        const SizedBox(height: 16),
        HistoricoCard(educando),
      ],
    );
  }
}
