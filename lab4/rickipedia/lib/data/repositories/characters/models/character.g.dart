// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  image: json['image'] as String,
  gender: json['gender'] as String,
  origin: CharacterPlace.fromJson(json['origin'] as Map<String, dynamic>),
  location: CharacterPlace.fromJson(json['location'] as Map<String, dynamic>),
  type: json['type'] as String? ?? '',
  episodes:
      (json['episode'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
  'species': instance.species,
  'image': instance.image,
  'gender': instance.gender,
  'origin': instance.origin.toJson(),
  'location': instance.location.toJson(),
  'type': instance.type,
  'episode': instance.episodes,
};

CharacterPlace _$CharacterPlaceFromJson(Map<String, dynamic> json) =>
    CharacterPlace(
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$CharacterPlaceToJson(CharacterPlace instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
