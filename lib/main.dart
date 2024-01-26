import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:inventaire_exo_muscu/generated/l10n.dart';
import 'package:inventaire_exo_muscu/models/hive/category_hive.dart';
import 'package:inventaire_exo_muscu/provider/parameter_notifier.dart';
import 'package:inventaire_exo_muscu/screens/splash.dart';


import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pour les opérations asynchrones avant runApp

  // Initialise Hive pour Flutter
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Enregistre l'adaptateur pour CategoryHive
  Hive.registerAdapter(CategoryHiveAdapter());

  await Hive.openBox<CategoryHive>('categoryBox');

  runApp(
    const ProviderScope(
      // Assurez-vous que ceci est correct
      child: MyApp(), // Remplacez par votre widget d'application principal
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);
    final themeNotifier = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: themeNotifier.getTheme(),
      home: const SplashScreen(),
    );
  }
}
