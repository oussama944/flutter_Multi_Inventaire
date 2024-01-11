import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/generated/l10n.dart';

class CustomDrawer extends StatelessWidget {


  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(S.of(context).title,
                style: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
