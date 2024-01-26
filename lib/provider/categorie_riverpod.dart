import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventaire_exo_muscu/models/hive/category_hive.dart';
import 'package:inventaire_exo_muscu/viewmodel/categorie_vm.dart';

class CategoryListNotifier extends StateNotifier<Map<String, CategoryHive>> {
  final HiveCategoryService _categoryService;

  CategoryListNotifier(this._categoryService) : super({}){
     
    loadCategories(); // Charger les catégories lors de l'initialisation
  
  }
  

  Future<void> loadCategories() async {
  try {
    var categories = await _categoryService.getAllCategories();
    state = categories;
  } catch (e) {
    // Gérer l'exception si nécessaire
    print('Erreur lors du chargement des catégories: $e');
  }
}

  Future<void> addCategory(String id, CategoryHive category) async {
    await _categoryService.addCategory(id, category);
    await loadCategories(); // Recharger les catégories après l'ajout
  }

  Future<void> deleteCategory(String id) async {
    await _categoryService.deleteCategory(id);
    await loadCategories(); // Recharger les catégories après la suppression
  }

  Future<void> updateCategory(String id, CategoryHive category) async {
    await _categoryService.updateCategory(id, category);
    await loadCategories(); // Recharger les catégories après la mise à jour
  }
}



final categoryListProvider = StateNotifierProvider<CategoryListNotifier, Map<String, CategoryHive>>(
  (ref) => CategoryListNotifier(ref.watch(hiveCategoryServiceProvider)),
);

final hiveCategoryServiceProvider = Provider((ref) => HiveCategoryService());
