import 'package:flutter/material.dart';

/// Grade de [StatTile] (ou qualquer widget) em N colunas cuja altura de cada linha se
/// ajusta ao conteúdo — evita overflow quando um valor (ex.: uma data longa) precisa de
/// mais espaço do que um aspect ratio fixo permitiria. Usa [IntrinsicHeight] para que a
/// altura da linha seja calculada a partir do conteúdo antes de esticar (`stretch`) todos
/// os itens da linha para a mesma altura.
class StatGrid extends StatelessWidget {
  const StatGrid({super.key, required this.children, this.crossAxisCount = 2, this.spacing = 12});

  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += crossAxisCount) {
      final rowChildren = <Widget>[];
      for (var j = 0; j < crossAxisCount; j++) {
        final idx = i + j;
        rowChildren.add(Expanded(child: idx < children.length ? children[idx] : const SizedBox()));
        if (j < crossAxisCount - 1) rowChildren.add(SizedBox(width: spacing));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: rowChildren),
        ),
      );
      if (i + crossAxisCount < children.length) rows.add(SizedBox(height: spacing));
    }
    return Column(children: rows);
  }
}
