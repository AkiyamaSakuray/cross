import 'package:dio/dio.dart';

import '../../endpoints.dart';
import 'character_repository_interface.dart';
import 'models/character.dart';

class CharacterRepository implements CharacterRepositoryInterface {
  CharacterRepository({required this.dio});
  final Dio dio;
  @override
  Future<List<Character>> getCharacters() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        Endpoints.characters,
        queryParameters: {'page': 1},
      );
      final results = response.data?['results'];
      if (results is! List) throw const FormatException('Отсутствует results');
      return List.unmodifiable(
        results.map(
          (json) => Character.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      );
    } on DioException catch (error) {
      throw CharacterLoadException(switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout =>
          'Сервер не ответил вовремя. Попробуйте ещё раз.',
        DioExceptionType.badResponse =>
          'Ошибка сервера (${error.response?.statusCode ?? 'неизвестно'}). Попробуйте ещё раз.',
        _ => 'Не удалось подключиться. Проверьте интернет и повторите запрос.',
      });
    } on FormatException {
      throw const CharacterLoadException('Сервер вернул некорректные данные.');
    } on TypeError {
      throw const CharacterLoadException('Сервер вернул некорректные данные.');
    }
  }
}

class CharacterLoadException implements Exception {
  const CharacterLoadException(this.message);
  final String message;
  @override
  String toString() => message;
}
