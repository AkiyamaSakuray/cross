import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/main.dart';
import 'package:rickipedia/di/di.dart';

void main() {
  setUp(setupLocator);
  tearDown(() => getIt.reset());
  testWidgets('catalog shows character name and description', (tester) async {
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    expect(find.text('Rickipedia'), findsOneWidget);
    expect(find.text('Персонажи'), findsOneWidget);
    expect(find.text('Рик Санчес'), findsOneWidget);
    expect(find.textContaining('Гениальный учёный'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('narrow screen scrolls to final character without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scrollable), findsWidgets);
    await tester.scrollUntilVisible(find.text('Абрадольф Линклер'), 250);
    expect(find.text('Абрадольф Линклер'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
