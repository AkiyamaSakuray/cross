# Rickipedia

Учебный Flutter-проект для лабораторных работ по кроссплатформенной
разработке.

## Лабораторная работа 1

В первой работе установлен Flutter SDK, создан Empty Application и подготовлен
статический стартовый экран. Сетевые запросы пока не выполняются.

## Предметная область и API

Предметная область — каталог персонажей вселенной «Рик и Морти».

- список персонажей: `GET https://rickandmortyapi.com/api/character`;
- персонаж по идентификатору:
  `GET https://rickandmortyapi.com/api/character/{id}`.

API будет подключён в последующих лабораторных работах.

## Запуск

```powershell
flutter pub get
flutter run -d chrome
```

## Проверка

```powershell
flutter analyze
flutter test
```

Flutter 3.47.4 на Windows может аварийно завершать `flutter analyze`, если
полный путь к проекту содержит кириллицу. В этом случае можно временно назначить
папке проекта латинскую букву диска и выполнять команды через неё:

```powershell
$projectPath = (Get-Location).Path
subst R: "$projectPath"
Set-Location R:\
flutter analyze
flutter test
```

Чтобы удалить временную букву диска, выполните `subst R: /D`.
