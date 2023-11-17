import 'package:eden_user_app/core/size_config/config.dart';
import 'package:eden_user_app/core/data_utils/theme.dart';
import 'package:eden_user_app/core/router/router.dart';
import 'package:eden_user_app/cubit_states.dart';
import 'package:eden_user_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EdenUserApp());
}

class EdenUserApp extends StatelessWidget {
  const EdenUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: getProviders(sl),
      child: AdaptiveTheme(
        light: AppTheme(Brightness.light).themeData,
        dark: AppTheme(Brightness.dark).themeData,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
