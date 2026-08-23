import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_euroforma/main.dart';

void main() {
  testWidgets('Login screen shows profile selector', (WidgetTester tester) async {
    await tester.pumpWidget(const EuroFormaApp());

    expect(find.text('Bem-vindo(a)'), findsOneWidget);
    expect(find.text('Educando'), findsWidgets);
    expect(find.text('Entrar como Educando'), findsOneWidget);
  });

  testWidgets('Selecting a profile and logging in shows the shell', (WidgetTester tester) async {
    await tester.pumpWidget(const EuroFormaApp());

    await tester.tap(find.text('Entrar como Educando'));
    await tester.pumpAndSettle();

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Meu perfil'), findsOneWidget);
  });
}
