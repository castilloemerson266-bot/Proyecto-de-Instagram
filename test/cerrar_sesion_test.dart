import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/pantallas/pantalla_inicio_sesion.dart';

void main() {
  testWidgets('Cerrar sesión regresa al formulario de acceso', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PantallaInicioSesion()),
    );

    await tester.enterText(find.byKey(const ValueKey('usernameField')), 'admin');
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      '123456',
    );
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Opciones de cuenta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('usernameField')), findsOneWidget);
  });
}
