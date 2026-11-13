# Rickipedia — лабораторные работы 1–4

Учебный проект по кроссплатформенной разработке на Flutter и Dart.
В каждой папке находится отдельная версия приложения и отчёт по работе.

| Работа | Содержание | Проект | Отчёт |
| --- | --- | --- | --- |
| 1 | Статический стартовый экран Flutter | [Исходники](lab1/rickipedia) | [DOCX](lab1/report.docx) |
| 2 | Локальный каталог персонажей | [Исходники](lab2/rickipedia) | [DOCX](lab2/report.docx) |
| 3 | Экран подробностей и навигация | [Исходники](lab3/rickipedia) | [DOCX](lab3/report.docx) |
| 4 | Rick and Morty API, Dio и BLoC | [Исходники](lab4/rickipedia) | [DOCX](lab4/report.docx) |

## Запуск

Требуется Flutter с Dart, совместимым с `^3.13.3` в `pubspec.yaml`.
Для запуска четвёртой работы из корня репозитория:

```powershell
cd lab4/rickipedia
flutter pub get
flutter run -d chrome
```

Для другой работы замените `lab4` на `lab1`, `lab2` или `lab3`.
При первом скачивании зависимостей нужен интернет. Четвёртая работа также
использует интернет при запуске для загрузки персонажей из API.

## Проверка

Из каталога нужного приложения:

```powershell
flutter analyze
flutter test
```

Подробности каждой работы описаны в её `README.md`.
Для работ 2–4 отдельные исходники настольных платформ сохранены
в соседнем с приложением каталоге `platforms`.
В работе 4 файл сериализации `character.g.dart` включён в исходники.
При изменении JSON-модели: `dart run build_runner build`.

Источник данных и изображений: [Rick and Morty API](https://rickandmortyapi.com/).
