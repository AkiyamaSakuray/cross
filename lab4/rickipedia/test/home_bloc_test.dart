import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';
import 'package:rickipedia/app/features/home/bloc/home_bloc.dart';
import 'package:rickipedia/app/features/home/character.dart';

import 'support/fixtures.dart';

void main() {
  HomeBloc makeBloc(FakeRepository repo) => HomeBloc(
    repository: repo,
    talker: Talker(settings: TalkerSettings(enabled: false)),
  );
  test('load emits loading then data and caches the selected item', () async {
    final bloc = makeBloc(FakeRepository(() async => sampleCharacters));
    addTearDown(bloc.close);
    final states = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<HomeLoadInProgress>(),
        isA<HomeLoadSuccess>().having(
          (s) => s.content,
          'content',
          sampleCharacters,
        ),
      ]),
    );
    final done = Completer<void>();
    bloc.add(HomeLoad(completer: done));
    await done.future;
    await states;
    expect(bloc.findById(2)?.name, 'Morty Smith');
    expect(bloc.findById(999), isNull);
  });
  test('failure completes refresh and retry recovers', () async {
    final repo = FakeRepository(() async => throw Exception('offline'));
    final bloc = makeBloc(repo);
    addTearDown(bloc.close);
    final failed = Completer<void>();
    bloc.add(HomeLoad(completer: failed));
    await failed.future;
    expect(bloc.state, isA<HomeLoadFailure>());
    repo.load = () async => sampleCharacters;
    final retry = Completer<void>();
    bloc.add(HomeLoad(completer: retry));
    await retry.future;
    expect(bloc.state, isA<HomeLoadSuccess>());
    expect(repo.calls, 2);
  });
  test('overlapping load events do not duplicate HTTP work', () async {
    final response = Completer<List<Character>>();
    final repo = FakeRepository(() => response.future);
    final bloc = makeBloc(repo);
    addTearDown(bloc.close);
    final first = Completer<void>();
    final second = Completer<void>();
    bloc.add(HomeLoad(completer: first));
    bloc.add(HomeLoad(completer: second));
    await second.future;
    response.complete(sampleCharacters);
    await first.future;
    expect(repo.calls, 1);
  });
  test('empty list is success and state includes its content', () async {
    final bloc = makeBloc(FakeRepository(() async => []));
    addTearDown(bloc.close);
    final done = Completer<void>();
    bloc.add(HomeLoad(completer: done));
    await done.future;
    expect(bloc.state, HomeLoadSuccess(content: []));
    expect(bloc.state, isNot(HomeLoadSuccess(content: sampleCharacters)));
  });
}
