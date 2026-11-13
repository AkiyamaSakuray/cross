import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/app/features/home/character.dart';
import 'package:rickipedia/app/router/router.dart';
import 'package:rickipedia/app/theme/theme.dart';
import 'package:rickipedia/di/di.dart';
import 'package:rickipedia/rickipedia.dart';

void main() {
  setUp(setupLocator);
  tearDown(() => getIt.reset());

  for (final character in characters) {
    testWidgets('opens and returns from character ${character.id}', (
      tester,
    ) async {
      await tester.pumpWidget(const RickipediaApp());
      await tester.pumpAndSettle();
      final card = find.byKey(ValueKey('character-${character.id}'));
      await tester.scrollUntilVisible(card, 200);
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      final list = find.byType(Scrollable).first;
      final offset = tester.state<ScrollableState>(list).position.pixels;
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.text('Подробности'), findsOneWidget);
      expect(find.text(character.name), findsOneWidget);
      await tester.scrollUntilVisible(find.text(character.biography), 200);
      expect(find.text(character.biography), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Назад к персонажам'));
      await tester.pumpAndSettle();
      expect(card, findsOneWidget);
      expect(tester.state<ScrollableState>(list).position.pixels, offset);
    });
  }

  testWidgets('direct link opens the selected character and returns home', (
    tester,
  ) async {
    final router = createRouter(initialLocation: '/home/character/2');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme),
    );
    await tester.pumpAndSettle();
    expect(find.text('Морти Смит'), findsOneWidget);
    expect(find.text('ID 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Назад к персонажам'));
    await tester.pumpAndSettle();
    expect(find.text('Персонажи'), findsOneWidget);
  });

  for (final id in ['999', 'abc']) {
    testWidgets('invalid character $id shows a recoverable empty state', (
      tester,
    ) async {
      final router = createRouter(initialLocation: '/home/character/$id');
      addTearDown(router.dispose);
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      expect(find.text('Персонаж не найден'), findsOneWidget);
      await tester.tap(find.text('К персонажам'));
      await tester.pumpAndSettle();
      expect(find.text('Персонажи'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [320.0, 1100.0]) {
    testWidgets('details fit width $width with enlarged text', (tester) async {
      tester.view.physicalSize = Size(width, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final router = createRouter(initialLocation: '/home/character/7');
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
      await tester.scrollUntilVisible(
        find.text(characters.last.biography),
        200,
      );
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(
        find.text('Локальная энциклопедия Rickipedia'),
        200,
      );
      expect(tester.takeException(), isNull);
    });
  }
}
