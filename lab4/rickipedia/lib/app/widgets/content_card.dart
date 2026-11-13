import 'package:flutter/material.dart';

import '../features/home/character.dart';
import '../extensions/extensions.dart';
import '../theme/theme.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'character-portrait-${character.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                character.image,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                semanticLabel: 'Портрет: ${character.name}',
                errorBuilder: (_, _, _) => const SizedBox(
                  width: 88,
                  height: 88,
                  child: Icon(Icons.person_outline, size: 42),
                ),
              ),
            ),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: text.titleLarge?.copyWith(
                    color: ThemeColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                5.ph,
                Text(
                  '${character.lifeStatus} · ${character.speciesLabel}',
                  style: text.labelMedium?.copyWith(color: ThemeColors.muted),
                ),
                8.ph,
                Text(
                  character.description,
                  style: text.bodyMedium?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
