import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventaire_exo_muscu/models/hive/category_hive.dart';
import 'package:inventaire_exo_muscu/provider/categorie_riverpod.dart';

class CategoriesHiveScreen extends ConsumerWidget {
  const CategoriesHiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: categories.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String key = categories.keys.elementAt(index);
                CategoryHive category = categories[key]!;

                return Dismissible(
                  key: Key(category
                      .id), // Assurez-vous que la clé est unique pour chaque élément
                  direction:
                      DismissDirection.endToStart, // Glisser de droite à gauche
                  onDismissed: (direction) {
                    // Logique pour supprimer l'élément
                    ref
                        .read(categoryListProvider.notifier)
                        .deleteCategory(category.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: ListTile(
                    title: Text(category.title),
                    subtitle: Text("ID: ${category.id}"),
                    trailing:
                        Icon(Icons.arrow_forward, color: Color(category.color)),
                    onTap: () {
                      // Gérez ici le clic sur un élément de la liste
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewCategory(context, ref),
        tooltip: 'Ajouter Catégorie',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewCategory(BuildContext context, WidgetRef ref) async {
    // ... La même logique pour afficher le dialogue et récupérer les données de l'utilisateur

// Initialisation des variables pour les paramètres
    String? id;
    String? title;
    int? color;

    // Afficher un dialogue pour saisir les informations
    bool? isSubmitted = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nouvelle Catégorie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'ID'),
                onChanged: (String value) {
                  id = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Titre'),
                onChanged: (String value) {
                  title = value;
                },
              ),
              // Ajouter un sélecteur de couleur ou un autre champ pour 'color'
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(false); // Ne pas ajouter la catégorie
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () {
                Navigator.of(context).pop(true); // Ajouter la catégorie
              },
            ),
          ],
        );
      },
    );

    if (isSubmitted == true && id != null && title != null) {
      var newCategory = CategoryHive(
          id: id!, title: title!, color: color ?? Colors.blue.value);

      // Ajoute la catégorie
      await ref
          .read(categoryListProvider.notifier)
          .addCategory(id!, newCategory);

      // Vérifie si le contexte est toujours monté avant d'afficher le SnackBar
      if (!context.mounted) return;

      final snackBar = SnackBar(
        content: Text('Catégorie "$title" ajoutée'),
        action: SnackBarAction(
          label: 'Annuler',
          onPressed: () {
            if (!context.mounted) return;
            ref.read(categoryListProvider.notifier).deleteCategory(id!);
          },
        ),
        duration: const Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Ferme automatiquement le SnackBar après 5 secondes
      await Future.delayed(const Duration(seconds: 5));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
