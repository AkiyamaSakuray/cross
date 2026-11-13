import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../di/di.dart';
import '../features/features.dart';

GoRouter createRouter() => GoRouter(
  initialLocation: '/home',
  observers: [TalkerRouteObserver(talker)],
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/home'),
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) =>
          MaterialPage(key: state.pageKey, child: const HomeScreen()),
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
