import 'package:flutter/material.dart';

class ResponsiveBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveBody({super.key, required this.child, this.maxWidth = 800});

  @override
  Widget build(BuildContext context) {
    // Obtention de la taille de l'écran
    final screenSize = MediaQuery.of(context).size;

    // Calcul de la largeur du contenu
    final contentWidth = screenSize.width < maxWidth ? screenSize.width : maxWidth;

    return Center(
      child: SizedBox(
        width: contentWidth,
        child: child,
      ),
    );
  }
}
