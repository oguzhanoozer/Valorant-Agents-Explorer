import 'package:agents_explorer/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stacked/stacked.dart';

import 'core/configs/theme/app_colors.dart';
import 'core/init/app_initializer.dart';
import 'core/routing/app_navigation.dart';
import 'core/services/localization/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColors.background,
    ),
  );

  await AppInitializer.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.unFocus(),
      child: ViewModelBuilder<ThemeController>.reactive(
          viewModelBuilder: () => ThemeController(),
          builder: (context, model, child) {
            return MaterialApp.router(
              theme: model.currentThemeData,
              darkTheme: model.darkTheme,
              themeMode: model.themeMode,
              routerConfig: AppNavigation.routerConfig,
              supportedLocales: supportedLocales,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          }),
    );
  }
}
