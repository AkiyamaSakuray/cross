import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/rickipedia.dart';
import 'package:rickipedia/app/router/router.dart';
import 'package:rickipedia/app/theme/theme.dart';
import 'package:rickipedia/di/di.dart';

import 'support/fixtures.dart';

void main() {
  tearDown(() => getIt.reset());
  testWidgets('API card opens matching details and back preserves catalog', (
    tester,
  ) async {
    await setupLocator(
      repository: FakeRepository(() async => sampleCharacters),
    );
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('character-1')));
    await tester.pumpAndSettle();
    expect(find.text('Подробности'), findsOneWidget);
    expect(find.text('Rick Sanchez'), findsOneWidget);
    await tester.tap(find.byTooltip('Назад к персонажам'));
    await tester.pumpAndSettle();
    expect(find.text('Персонажи'), findsOneWidget);
  });
  for (final id in ['2', '999', 'abc']) {
    testWidgets('direct link resolves loaded ID $id', (tester) async {
      await setupLocator(
        repository: FakeRepository(() async => sampleCharacters),
      );
      final router = createRouter(initialLocation: '/home/character/$id');
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(id == '2' ? 'Morty Smith' : 'Персонаж не найден'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }
  for (final width in [320.0, 1100.0]) {
    testWidgets('catalog and details fit $width at 150 percent text', (
      tester,
    ) async {
      await setupLocator(
        repository: FakeRepository(() async => sampleCharacters),
      );
      tester.view.physicalSize = Size(width, 720);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final router = createRouter();
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.lightTheme,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(1.5)),
            child: child!,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final card = find.byKey(const ValueKey('character-1'));
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      await tester.tap(card);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Источник: Rick and Morty API'),
        250,
      );
      expect(tester.takeException(), isNull);
    });
  }
}
