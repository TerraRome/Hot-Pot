import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_pot/core/router/app_router.dart';
import 'package:hot_pot/core/theme/app_theme.dart';
import 'package:hot_pot/core/constants/app_constants.dart';

/// Disable Android 12+ overscroll stretch effect globally.
class _NoStretchScrollBehavior extends MaterialScrollBehavior {
  const _NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // removes glow AND stretch indicator
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      scrollBehavior: const _NoStretchScrollBehavior(),
      routerConfig: appRouter,
    );
  }
}
