import 'package:flutter/material.dart';

void main() => runApp(const RickipediaApp());

class RickipediaApp extends StatelessWidget {
  const RickipediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF173B36);
    const lime = Color(0xFFB7E334);

    return MaterialApp(
      title: 'Rickipedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkGreen,
          primary: darkGreen,
          secondary: lime,
          surface: const Color(0xFFF5FAF8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5FAF8),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rickipedia'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.rocket_launch_rounded,
                  size: 80,
                  color: colors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Проект создан',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Каталог персонажей вселенной «Рик и Морти»',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Chip(
                  label: const Text('Лабораторная №1'),
                  backgroundColor: colors.secondary,
                  side: BorderSide.none,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
