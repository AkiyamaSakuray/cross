class Character {
  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });
  final int id;
  final String name;
  final String description;
  final String status;
  String get imagePath => 'assets/images/$id.jpg';
}

const characters = [
  Character(
    id: 1,
    name: 'Рик Санчес',
    status: 'Жив · Человек',
    description: 'Гениальный учёный и изобретатель портальной пушки. Путешествует по вселенным вместе с внуком Морти.',
  ),
  Character(
    id: 2,
    name: 'Морти Смит',
    status: 'Жив · Человек',
    description: 'Внук Рика и его спутник в межпространственных приключениях. Часто оказывается голосом здравого смысла.',
  ),
  Character(
    id: 3,
    name: 'Саммер Смит',
    status: 'Жива · Человек',
    description: 'Старшая сестра Морти. Решительная и находчивая, всё чаще присоединяется к приключениям семьи.',
  ),
  Character(
    id: 4,
    name: 'Бет Смит',
    status: 'Жива · Человек',
    description: 'Дочь Рика, мать Морти и Саммер. Работает ветеринарным хирургом и унаследовала характер отца.',
  ),
  Character(
    id: 5,
    name: 'Джерри Смит',
    status: 'Жив · Человек',
    description: 'Отец Морти и Саммер. Предпочитает спокойную семейную жизнь опасным экспериментам Рика.',
  ),
  Character(
    id: 7,
    name: 'Абрадольф Линклер',
    status: 'Неизвестно · Гуманоид',
    description: 'Результат необычного эксперимента Рика. Пытается разобраться в противоречиях собственной личности.',
  ),
];
