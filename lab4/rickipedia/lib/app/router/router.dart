import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../features/features.dart';
import '../features/home/character.dart';
import '../features/home/bloc/home_bloc.dart';

GoRouter createRouter({String? initialLocation}) => GoRouter(
  initialLocation: initialLocation,
  observers: [TalkerRouteObserver(talker)],
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/home'),
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) =>
          MaterialPage(key: state.pageKey, child: const HomeScreen()),
      routes: [
        GoRoute(
          path: 'character/:id',
          name: 'character',
          builder: (_, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            final home = getIt<HomeBloc>();
            if (home.state is HomeInitial) home.add(const HomeLoad());
            return BlocBuilder<HomeBloc, HomeState>(
              bloc: home,
              builder: (context, homeState) {
                final character = state.extra is Character
                    ? state.extra as Character
                    : home.findById(id);
                if (character == null &&
                    (homeState is HomeInitial ||
                        homeState is HomeLoadInProgress)) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (character == null && homeState is HomeLoadFailure) {
                  return Scaffold(
                    appBar: AppBar(title: const Text('Подробности')),
                    body: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            homeState.exception.toString(),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () => home.add(const HomeLoad()),
                            child: const Text('Повторить'),
                          ),
                          TextButton(
                            onPressed: () => context.go('/home'),
                            child: const Text('К персонажам'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return CharacterDetailsScreen(character: character);
              },
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Rickipedia')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Страница не найдена'),
          TextButton(
            onPressed: () => context.go('/home'),
            child: const Text('К персонажам'),
          ),
        ],
      ),
    ),
  ),
);
