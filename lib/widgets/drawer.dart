import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/generated/l10n.dart';
import 'package:inventaire_exo_muscu/screens/parameter_screen.dart';
import 'package:inventaire_exo_muscu/screens/hive/test_hive.dart';

class CustomDrawer extends StatelessWidget {


  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParameterScreen()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('hive test '),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesHiveScreen()),
                );
              },
            ),

            // Ajoutez d'autres éléments ici si nécessaire
          ],
        ),
    );
  }
}
