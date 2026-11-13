import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.gender,
    required this.origin,
    required this.location,
    this.type = '',
    this.episodes = const [],
  });
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String gender;
  final CharacterPlace origin;
  final CharacterPlace location;
  final String type;
  @JsonKey(name: 'episode')
  final List<String> episodes;
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  String get lifeStatus => switch (status) {
    'Alive' => 'Жив',
    'Dead' => 'Мёртв',
    _ => 'Неизвестно',
  };
  String get speciesLabel => switch (species) {
    'Human' => 'Человек',
    'Alien' => 'Инопланетянин',
    'Humanoid' => 'Гуманоид',
    _ => species,
  };
  String get description => 'Местонахождение: ${location.name}';
  String get biography =>
      'Происхождение: ${origin.name}. '
      'Пол: $gender. Эпизодов: ${episodes.length}.'
      '${type.isEmpty ? '' : ' Подвид: $type.'}';
  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    image,
    gender,
    origin,
    location,
    type,
    episodes,
  ];
}

@JsonSerializable()
class CharacterPlace extends Equatable {
  const CharacterPlace({required this.name, this.url = ''});
  final String name;
  final String url;
  factory CharacterPlace.fromJson(Map<String, dynamic> json) =>
      _$CharacterPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterPlaceToJson(this);
  @override
  List<Object?> get props => [name, url];
}
