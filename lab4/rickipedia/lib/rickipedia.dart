import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app/app.dart';

class RickipediaApp extends StatefulWidget {
  const RickipediaApp({super.key});
  @override
  State<RickipediaApp> createState() => _RickipediaAppState();
}

class _RickipediaAppState extends State<RickipediaApp> {
  late final GoRouter _router = createRouter();
  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Rickipedia',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    routerConfig: _router,
  );
}
