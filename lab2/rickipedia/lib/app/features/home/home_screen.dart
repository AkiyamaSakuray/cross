import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Rickipedia'),
      leading: const Icon(Icons.public, color: ThemeColors.lime),
    ),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            itemCount: characters.length + 1,
            separatorBuilder: (_, index) => index == 0
                ? 12.ph
                : const Divider(height: 1, color: Color(0xFFD9E5DF)),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ВСЕЛЕННАЯ РИКА И МОРТИ',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ThemeColors.muted,
                        letterSpacing: 1.4,
                      ),
                    ),
                    10.ph,
                    Text(
                      'Персонажи',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: ThemeColors.accent,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    10.ph,
                    const Text(
                      'Знакомые лица из бесконечного множества миров.',
                    ),
                    18.ph,
                    const Text(
                      '6 персонажей',
                      style: TextStyle(color: ThemeColors.muted),
                    ),
                  ],
                );
              }
              return ContentCard(character: characters[index - 1]);
            },
          ),
        ),
      ),
    ),
  );
}
