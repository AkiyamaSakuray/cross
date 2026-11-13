import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/home/bloc/home_bloc.dart';
import '../data/dio/set_up.dart';
import '../data/repositories/characters/character_repository.dart';
import '../data/repositories/characters/character_repository_interface.dart';

final getIt = GetIt.instance;
Talker get talker => getIt<Talker>();
Future<void> setupLocator({CharacterRepositoryInterface? repository}) async {
  if (getIt.isRegistered<HomeBloc>()) return;
  getIt.registerSingleton<Talker>(TalkerFlutter.init());
  final dio = Dio();
  setUpDio(dio, talker);
  getIt.registerSingleton<Dio>(
    dio,
    dispose: (client) => client.close(force: true),
  );
  Bloc.observer = TalkerBlocObserver(talker: talker);
  getIt.registerSingleton<CharacterRepositoryInterface>(
    repository ?? CharacterRepository(dio: dio),
  );
  getIt.registerSingleton<HomeBloc>(
    HomeBloc(repository: getIt<CharacterRepositoryInterface>(), talker: talker),
    dispose: (bloc) => bloc.close(),
  );
}
