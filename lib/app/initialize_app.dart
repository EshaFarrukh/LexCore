import 'package:flutter/material.dart';
import 'package:lex_core/app/router/app_router.dart';
import 'package:lex_core/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LexCore — Legal Command Center',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.translucent,
          child: child,
        );
      },
    );
  }
}
