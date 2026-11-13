import 'models/character.dart';

abstract interface class CharacterRepositoryInterface {
  Future<List<Character>> getCharacters();
}
