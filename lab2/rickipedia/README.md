# Rickipedia — лабораторная работа 2

Первый экран каталога персонажей «Рика и Морти» по методичке ../assignment.docx.
В приложении 6 локальных записей с портретами, именами, статусами и описаниями.
Список прокручивается и адаптируется к ширине экрана. Интернет при просмотре
каталога не требуется. API и экран деталей остаются для следующих работ.

## Запуск

Требуется Flutter с Dart 3.13.3 или совместимой более новой версией.
Из каталога проекта:

```powershell
flutter pub get
flutter run -d chrome
```

## Проверка и сборка

```powershell
flutter analyze
flutter test
flutter build web --no-web-resources-cdn
```

На этом компьютере проверены Flutter 3.47.4, Dart 3.13.3 и Chrome.
Android, iOS и настольные сборки в рамках работы не проверялись.
Для Windows исходная заготовка сохранена отдельно в ../platforms/windows.
Для её использования скопируйте папку windows в корень проекта и настройте
режим разработчика Windows для поддержки символических ссылок плагинов.

Если анализатор Flutter некорректно работает с кириллицей в пути, подключите
проект как свободный диск (в примере L):

```powershell
subst L: (Get-Location).Path
Set-Location L:\
flutter analyze
flutter test
flutter run -d chrome
```

После завершения выйдите из L:\ и освободите букву командой `subst L: /D`.

## Структура

- lib/main.dart — запуск, ожидание DI, обработка ошибок;
- lib/rickipedia.dart — MaterialApp.router и жизненный цикл маршрутизатора;
- lib/di/di.dart — регистрация общего Talker в GetIt;
- lib/app/router/router.dart — /home, переход с / и неизвестный маршрут;
- lib/app/theme — палитра и тема Material 3;
- lib/app/extensions — короткая запись отступов;
- lib/app/features/home — экран, модель и локальные данные;
- lib/app/widgets/content_card.dart — повторно используемая карточка;
- assets/images — шесть портретов;
- test/widget_test.dart — содержимое каталога и прокрутка при ширине 320 px.

## Источники

Портреты: https://rickandmortyapi.com/api/character/avatar/{id}.jpeg
Идентификаторы: 1, 2, 3, 4, 5, 7. Файлы загружены один раз при подготовке.
Источник проекта и данных: https://rickandmortyapi.com/
Изображения персонажей принадлежат соответствующим правообладателям;
используются в учебном проекте.

Зависимости по методичке: go_router 18.0.2, get_it 9.3.0,
talker 5.1.20, talker_flutter 5.1.20. Разрешённые версии зафиксированы в pubspec.lock.
