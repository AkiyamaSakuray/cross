import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickipedia/app/features/home/character.dart';
import 'package:rickipedia/data/repositories/characters/character_repository.dart';

import 'support/fixtures.dart';

class StubAdapter implements HttpClientAdapter {
  StubAdapter(this.reply);
  final ResponseBody Function(RequestOptions) reply;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => reply(options);
  @override
  void close({bool force = false}) {}
}

void main() {
  test(
    'generated JSON roundtrip preserves nested fields and episode mapping',
    () {
      final json = characterJson();
      final character = Character.fromJson(json);
      expect(character.toJson(), json);
      expect(Character.fromJson(json), character);
      expect(character.lifeStatus, 'Жив');
      expect(character.description, contains('Citadel'));
    },
  );
  test('repository sends GET /character?page=1 and reads results', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));
    addTearDown(dio.close);
    dio.httpClientAdapter = StubAdapter((options) {
      expect(options.method, 'GET');
      expect(options.uri.path, '/api/character');
      expect(options.queryParameters['page'], 1);
      return ResponseBody.fromString(
        jsonEncode({
          'results': [characterJson()],
        }),
        200,
        headers: {
          Headers.contentTypeHeader: ['application/json'],
        },
      );
    });
    expect(await CharacterRepository(dio: dio).getCharacters(), [
      sampleCharacters.first,
    ]);
  });
  for (final status in [500, 503]) {
    test('HTTP $status becomes a readable repository exception', () async {
      final dio = Dio()
        ..httpClientAdapter = StubAdapter(
          (_) => ResponseBody.fromString('{}', status),
        );
      addTearDown(dio.close);
      await expectLater(
        CharacterRepository(dio: dio).getCharacters(),
        throwsA(
          isA<CharacterLoadException>().having(
            (e) => e.message,
            'status',
            contains('$status'),
          ),
        ),
      );
    });
  }
  test('timeout has a readable message', () async {
    final dio = Dio()
      ..httpClientAdapter = StubAdapter(
        (options) => throw DioException(
          requestOptions: options,
          type: DioExceptionType.connectionTimeout,
        ),
      );
    addTearDown(dio.close);
    await expectLater(
      CharacterRepository(dio: dio).getCharacters(),
      throwsA(
        isA<CharacterLoadException>().having(
          (e) => e.message,
          'message',
          contains('вовремя'),
        ),
      ),
    );
  });
  for (final payload in [
    <String, dynamic>{},
    {
      'results': [
        {'id': 'wrong'},
      ],
    },
    {'results': null},
  ]) {
    test('invalid JSON structure is rejected: $payload', () async {
      final dio = Dio()
        ..httpClientAdapter = StubAdapter(
          (_) => ResponseBody.fromString(
            jsonEncode(payload),
            200,
            headers: {
              Headers.contentTypeHeader: ['application/json'],
            },
          ),
        );
      addTearDown(dio.close);
      await expectLater(
        CharacterRepository(dio: dio).getCharacters(),
        throwsA(isA<CharacterLoadException>()),
      );
    });
  }
  test('empty results is a successful empty list', () async {
    final dio = Dio()
      ..httpClientAdapter = StubAdapter(
        (_) => ResponseBody.fromString(
          '{"results":[]}',
          200,
          headers: {
            Headers.contentTypeHeader: ['application/json'],
          },
        ),
      );
    addTearDown(dio.close);
    expect(await CharacterRepository(dio: dio).getCharacters(), isEmpty);
  });
}
