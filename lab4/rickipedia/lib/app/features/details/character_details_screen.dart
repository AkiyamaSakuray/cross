import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../home/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character? character;

  @override
  Widget build(BuildContext context) {
    final item = character;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробности'),
        leading: IconButton(
          tooltip: 'Назад к персонажам',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: SafeArea(
        child: item == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_search_outlined, size: 64),
                      16.ph,
                      const Text('Персонаж не найден'),
                      12.ph,
                      TextButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('К персонажам'),
                      ),
                    ],
                  ),
                ),
              )
            : Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 880),
                  child: SingleChildScrollView(
                    key: const ValueKey('character-details-scroll'),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: 'character-portrait-${item.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ColoredBox(
                              color: const Color(0xFFE3EEE8),
                              child: Image.network(
                                item.image,
                                height: 280,
                                fit: BoxFit.contain,
                                semanticLabel: 'Портрет: ${item.name}',
                                errorBuilder: (_, _, _) => const SizedBox(
                                  height: 280,
                                  child: Icon(Icons.person_outline, size: 80),
                                ),
                              ),
                            ),
                          ),
                        ),
                        24.ph,
                        Text(
                          item.name,
                          style: text.headlineLarge?.copyWith(
                            color: ThemeColors.accent,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        12.ph,
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(
                              avatar: Icon(
                                item.lifeStatus == 'Неизвестно'
                                    ? Icons.help_outline
                                    : Icons.favorite_outline,
                                size: 18,
                              ),
                              label: Text(item.lifeStatus),
                            ),
                            Chip(label: Text(item.speciesLabel)),
                            Chip(label: Text('ID ${item.id}')),
                          ],
                        ),
                        20.ph,
                        Text(
                          item.description,
                          style: text.bodyLarge?.copyWith(height: 1.6),
                        ),
                        24.ph,
                        Text(
                          'О персонаже',
                          style: text.titleLarge?.copyWith(
                            color: ThemeColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        12.ph,
                        Text(
                          item.biography,
                          style: text.bodyLarge?.copyWith(height: 1.6),
                        ),
                        24.ph,
                        const Divider(),
                        12.ph,
                        Text(
                          'Источник: Rick and Morty API',
                          style: text.bodySmall?.copyWith(
                            color: ThemeColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
