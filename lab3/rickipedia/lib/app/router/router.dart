import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../features/features.dart';
import '../features/home/character.dart';

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
            final character = characters
                .where((item) => item.id == id)
                .firstOrNull;
            return CharacterDetailsScreen(character: character);
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
