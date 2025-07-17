// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';
import 'package:image_compressor_app/main.dart'; // Importa tu MyApp

void main() {
  testWidgets('App bar title is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar title is displayed.
    expect(find.text('Compresor de Imágenes'), findsOneWidget);
  });
}