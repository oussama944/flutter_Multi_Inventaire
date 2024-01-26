import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventaire_exo_muscu/provider/parameter_notifier.dart';
import 'package:inventaire_exo_muscu/theme/theme.dart';
import 'package:provider/provider.dart';

class ParameterScreen extends ConsumerWidget {
  const ParameterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Paramètres de Thème")),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Thème Sombre"),
            trailing: Switch(
              value: themeNotifier.getTheme() == darkTheme,
              onChanged: (value) {
                themeNotifier.setTheme(value ? darkTheme : lightTheme);
              },
            ),
          ),
        ],
      ),
    );
  }
}
