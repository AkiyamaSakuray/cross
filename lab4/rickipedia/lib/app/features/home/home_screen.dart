import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _home = getIt<HomeBloc>();
  @override
  void initState() {
    super.initState();
    if (_home.state is HomeInitial) _home.add(const HomeLoad());
  }

  Future<void> _refresh() {
    final completer = Completer<void>();
    _home.add(HomeLoad(completer: completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Rickipedia'),
      leading: const Icon(Icons.public, color: ThemeColors.lime),
      actions: [
        BlocBuilder<HomeBloc, HomeState>(
          bloc: _home,
          builder: (_, state) => IconButton(
            tooltip: 'Обновить',
            onPressed: state is HomeLoadInProgress
                ? null
                : () => _home.add(const HomeLoad()),
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _home,
            builder: (context, state) => switch (state) {
              HomeInitial() || HomeLoadInProgress() => const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Загрузка персонажей',
                ),
              ),
              HomeLoadFailure() => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud_off_outlined, size: 56),
                      const SizedBox(height: 16),
                      Text(
                        'Не удалось загрузить персонажей',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.exception.toString(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      FilledButton.icon(
                        onPressed: () => _home.add(const HomeLoad()),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              ),
              HomeLoadSuccess() => RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.separated(
                  key: const PageStorageKey('characters-list'),
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  itemCount: state.content.length + 1,
                  separatorBuilder: (_, index) => index == 0
                      ? const SizedBox(height: 12)
                      : const Divider(height: 1, color: Color(0xFFD9E5DF)),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ВСЕЛЕННАЯ РИКА И МОРТИ',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: ThemeColors.muted,
                                  letterSpacing: 1.4,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Персонажи',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: ThemeColors.accent,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Знакомые лица из бесконечного множества миров.',
                          ),
                          const SizedBox(height: 18),
                          Text(
                            state.content.isEmpty
                                ? 'Персонажи не найдены'
                                : 'Загружено: ${state.content.length} · Страница 1',
                            style: const TextStyle(color: ThemeColors.muted),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Rick and Morty API',
                            style: TextStyle(color: ThemeColors.muted),
                          ),
                        ],
                      );
                    }
                    final character = state.content[index - 1];
                    return Semantics(
                      button: true,
                      child: InkWell(
                        key: ValueKey('character-${character.id}'),
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => context.pushNamed(
                          'character',
                          pathParameters: {'id': '${character.id}'},
                          extra: character,
                        ),
                        child: ContentCard(character: character),
                      ),
                    );
                  },
                ),
              ),
            },
          ),
        ),
      ),
    ),
  );
}
