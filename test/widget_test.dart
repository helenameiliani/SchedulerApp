import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scheduller_app/login_page.dart';
import 'package:scheduller_app/main.dart';

void main() {
  testWidgets('Welcome Screen UI Test', (WidgetTester tester) async {
    // Bangun aplikasi dan trigger frame.
    await tester.pumpWidget(MyApp());

    // Verifikasi bahwa teks "WELCOME TO SCHEDULER APP" muncul
    expect(find.text('WELCOME TO SCHEDULER APP'), findsOneWidget);

    // Verifikasi bahwa gambar ilustrasi muncul
    expect(find.byType(Image), findsOneWidget);

    // Verifikasi tombol "GET STARTED" muncul
    expect(find.text('GET STARTED'), findsOneWidget);

    // Verifikasi tombol 'GET STARTED' bisa ditekan
    await tester.tap(find.text('GET STARTED'));
    await tester.pumpAndSettle();

    // Verifikasi bahwa setelah menekan tombol, navigasi menuju halaman login
    expect(find.byType(LoginPage() as Type), findsOneWidget);
  });
}
