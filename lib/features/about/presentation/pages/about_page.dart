import 'package:flutter/material.dart';
import 'package:hot_pot/core/utils/extensions.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Me', style: context.textTheme.headlineMedium),
            16.verticalSpace,
            Text(
              'Flutter developer passionate about building great user experiences. '
              'Skilled in clean architecture, state management with Riverpod, '
              'and delivering polished, production-ready apps.',
              style: context.textTheme.bodyLarge,
            ),
            32.verticalSpace,
            Text('Skills', style: context.textTheme.titleLarge),
            16.verticalSpace,
            const _SkillChips(
              skills: [
                'Flutter',
                'Dart',
                'Riverpod',
                'Go Router',
                'Clean Architecture',
                'REST API',
                'Firebase',
                'Git',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChips extends StatelessWidget {
  const _SkillChips({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map(
            (skill) => Chip(
              label: Text(skill),
              backgroundColor: context.colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          )
          .toList(),
    );
  }
}
