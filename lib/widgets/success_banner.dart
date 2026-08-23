import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Aviso de sucesso simples usado após ações mockadas (cadastro, salvar alterações).
class SuccessBanner extends StatelessWidget {
  const SuccessBanner(this.mensagem, {super.key});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.successGreenBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.successGreenBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.successGreen, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(mensagem, style: const TextStyle(color: AppColors.successGreen, fontSize: 13))),
        ],
      ),
    );
  }
}
