import 'package:rickipedia/data/repositories/characters/character_repository_interface.dart';
import 'package:rickipedia/app/features/home/character.dart';

Map<String, dynamic> characterJson({
  int id = 1,
  String name = 'Rick Sanchez',
}) => {
  'id': id,
  'name': name,
  'status': 'Alive',
  'species': 'Human',
  'type': '',
  'gender': 'Male',
  'image': 'https://example.com/$id.jpg',
  'origin': {'name': 'Earth (C-137)', 'url': ''},
  'location': {'name': 'Citadel of Ricks', 'url': ''},
  'episode': ['https://rickandmortyapi.com/api/episode/1'],
};
final sampleCharacters = [
  Character.fromJson(characterJson()),
  Character.fromJson(characterJson(id: 2, name: 'Morty Smith')),
];

class FakeRepository implements CharacterRepositoryInterface {
  FakeRepository(this.load);
  Future<List<Character>> Function() load;
  int calls = 0;
  @override
  Future<List<Character>> getCharacters() {
    calls++;
    return load();
  }
}
