import 'package:flutter/material.dart';
import 'package:hot_pot/core/utils/extensions.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const _projects = [
    _Project(
      title: 'Hot Pot App',
      description: 'Portfolio showcase app built with Flutter, Riverpod, and Go Router.',
      tags: ['Flutter', 'Riverpod', 'Go Router'],
    ),
    _Project(
      title: 'E-Commerce App',
      description: 'Full-featured shopping app with cart, checkout, and payment integration.',
      tags: ['Flutter', 'Firebase', 'Stripe'],
    ),
    _Project(
      title: 'Task Manager',
      description: 'Productivity app with offline support using local database.',
      tags: ['Flutter', 'Isar', 'Riverpod'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _projects.length,
        separatorBuilder: (_, __) => 16.verticalSpace,
        itemBuilder: (context, index) => _ProjectCard(
          project: _projects[index],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final _Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title, style: context.textTheme.titleLarge),
            8.verticalSpace,
            Text(
              project.description,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            12.verticalSpace,
            Wrap(
              spacing: 6,
              children: project.tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag, style: context.textTheme.labelLarge),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: context.colorScheme.secondaryContainer,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Project {
  const _Project({
    required this.title,
    required this.description,
    required this.tags,
  });

  final String title;
  final String description;
  final List<String> tags;
}
