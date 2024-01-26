import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/hive/category_hive.dart';
import 'package:inventaire_exo_muscu/viewmodel/categorie_vm.dart';

class CategoriesHiveScreen extends StatefulWidget {
  const CategoriesHiveScreen({super.key});

  @override
  CategoriesScreenHiveState createState() => CategoriesScreenHiveState();
}

class CategoriesScreenHiveState extends State<CategoriesHiveScreen> {
  final HiveCategoryService _categoryService = HiveCategoryService();

   Map<String, CategoryHive>? categories; // Variable pour stocker les catégories

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await _categoryService.openCategoryBox();
    _refreshCategories(); // Chargement initial des catégories
  }

  Future<void> _refreshCategories() async {
    var newCategories = await _categoryService.getAllCategories();
    setState(() {
      categories = newCategories; // Mise à jour de l'état avec les nouvelles catégories
    });
  }

    // Modifier la signature de la méthode pour renvoyer les données des catégories
  Future<Map<String, CategoryHive>> _loadCategories() async {
    return await _categoryService.getAllCategories();
  }



  void _addNewCategory() async {
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
              decoration: InputDecoration(hintText: 'ID'),
              onChanged: (String value) {
                id = value;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Titre'),
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

  // Vérifier si l'utilisateur a soumis le formulaire
  if (isSubmitted == true && id != null && title != null ) {
    // Créer la catégorie
    var newCategory = CategoryHive(id: id!, title: title!);

    // Ajouter la catégorie via le service Hive
    await _categoryService.addCategory(id!, newCategory);

    setState(() {}); // Mettre à jour l'interface utilisateur
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: FutureBuilder(
        future: _loadCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Erreur: ${snapshot.error}");
          }

         
        // Récupération des données
        var categories = snapshot.data!;

        // Construction de la ListView
        return ListView.builder(
              itemCount: categories!.length,
              itemBuilder: (context, index) {
                String key = categories!.keys.elementAt(index);
                CategoryHive category = categories![key]!;

                return ListTile(
                  title: Text(category.title),
                  subtitle: Text("ID: ${category.id}"),
                  trailing: Icon(Icons.arrow_forward, color: Color(category.color)),
                  onTap: () {
                    // Gérez ici le clic sur un élément de la liste
                  },
                );
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCategory,
        tooltip: 'Ajouter Catégorie',
        child: Icon(Icons.add),
      ),
    );
  }
}
