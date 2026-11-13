import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;
Talker get talker => getIt<Talker>();
Future<void> setupLocator() async {
  if (!getIt.isRegistered<Talker>()) {
    getIt.registerSingleton<Talker>(TalkerFlutter.init());
  }
}
