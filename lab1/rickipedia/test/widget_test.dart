import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/main.dart';

void main() {
  testWidgets('shows the lab identity and selected subject area', (
    tester,
  ) async {
    await tester.pumpWidget(const RickipediaApp());

    expect(find.text('Rickipedia'), findsOneWidget);
    expect(find.text('Проект создан'), findsOneWidget);
    expect(
      find.text('Каталог персонажей вселенной «Рик и Морти»'),
      findsOneWidget,
    );
    expect(find.text('Лабораторная №1'), findsOneWidget);
    expect(find.byIcon(Icons.rocket_launch_rounded), findsOneWidget);
  });
}
