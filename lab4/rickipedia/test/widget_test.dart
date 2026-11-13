import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/rickipedia.dart';
import 'package:rickipedia/di/di.dart';
import 'package:rickipedia/app/features/home/character.dart';

import 'support/fixtures.dart';

void main() {
  tearDown(() => getIt.reset());
  testWidgets('shows loading then API character and refresh action', (
    tester,
  ) async {
    final response = Completer<List<Character>>();
    final repo = FakeRepository(() => response.future);
    await setupLocator(repository: repo);
    await tester.pumpWidget(const RickipediaApp());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    response.complete(sampleCharacters);
    await tester.pumpAndSettle();
    expect(find.text('Rick Sanchez'), findsOneWidget);
    expect(find.text('Загружено: 2 · Страница 1'), findsOneWidget);
    repo.load = () async => sampleCharacters;
    await tester.tap(find.byTooltip('Обновить'));
    await tester.pumpAndSettle();
    expect(repo.calls, 2);
    expect(tester.takeException(), isNull);
  });
  testWidgets('error is visible and retry restores catalog', (tester) async {
    final repo = FakeRepository(() async => throw Exception('Нет соединения'));
    await setupLocator(repository: repo);
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    expect(find.text('Не удалось загрузить персонажей'), findsOneWidget);
    repo.load = () async => sampleCharacters;
    await tester.tap(find.text('Повторить'));
    await tester.pumpAndSettle();
    expect(find.text('Rick Sanchez'), findsOneWidget);
  });
  testWidgets('empty response shows a usable empty state', (tester) async {
    await setupLocator(repository: FakeRepository(() async => []));
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    expect(find.text('Персонажи не найдены'), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
  });
  testWidgets('pull to refresh sends a second repository request', (
    tester,
  ) async {
    final repo = FakeRepository(() async => sampleCharacters);
    await setupLocator(repository: repo);
    await tester.pumpWidget(const RickipediaApp());
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, 400));
    await tester.pumpAndSettle();
    expect(repo.calls, 2);
  });
}
