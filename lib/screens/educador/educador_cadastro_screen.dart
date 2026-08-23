import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Formulário de cadastro de um novo educando (dado mockado, sem persistência real).
class EducadorCadastroScreen extends StatefulWidget {
  const EducadorCadastroScreen({super.key, required this.cursos, required this.onCadastrar});

  final List<String> cursos;
  final void Function(String nome, String cpf, String telefone, String email, String curso) onCadastrar;

  @override
  State<EducadorCadastroScreen> createState() => _EducadorCadastroScreenState();
}

class _EducadorCadastroScreenState extends State<EducadorCadastroScreen> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _curso;

  bool get _valido => _nomeController.text.trim().isNotEmpty && _emailController.text.trim().isNotEmpty && _curso != null;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _limpar() {
    _nomeController.clear();
    _cpfController.clear();
    _telefoneController.clear();
    _emailController.clear();
    setState(() => _curso = null);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Novo cadastro', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Text('Cadastrar educando', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text(
          'As informações são armazenadas de forma centralizada e segura.',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Informações do educando', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                const Text('Nome completo *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(hintText: 'Ex: Maria da Silva'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CPF', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          const SizedBox(height: 6),
                          TextField(controller: _cpfController, decoration: const InputDecoration(hintText: '000.000.000-00')),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Telefone', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          const SizedBox(height: 6),
                          TextField(controller: _telefoneController, decoration: const InputDecoration(hintText: '(11) 90000-0000')),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text('E-mail *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'email@exemplo.com'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 14),
                const Text('Curso *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _curso,
                  decoration: const InputDecoration(hintText: 'Selecione um curso'),
                  items: widget.cursos.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) => setState(() => _curso = v),
                ),
                const SizedBox(height: 12),
                const Row(children: [
                  Icon(Icons.lock, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Text('Dados armazenados com criptografia', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ]),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: AppColors.euroBlueDark),
                    onPressed: _valido
                        ? () {
                            widget.onCadastrar(
                              _nomeController.text.trim(),
                              _cpfController.text.trim(),
                              _telefoneController.text.trim(),
                              _emailController.text.trim(),
                              _curso!,
                            );
                            _limpar();
                          }
                        : null,
                    icon: const Icon(Icons.person_add_alt),
                    label: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
