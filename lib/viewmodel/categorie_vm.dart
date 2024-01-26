import 'package:hive/hive.dart';
import 'package:inventaire_exo_muscu/models/hive/category_hive.dart';

abstract class DatabaseCategoryService {
  Future<void> addCategory(String key, CategoryHive value);
  dynamic getCategory(String key);
  Future<void> updateCategory(String key, CategoryHive value);
  Future<void> deleteCategory(String key);
  Future<Map<String, CategoryHive>> getAllCategories();
}

class HiveCategoryService implements DatabaseCategoryService {
  Box<CategoryHive>? _categoryBox;

  HiveCategoryService() {
    openCategoryBox();
  }

  Future<void> openCategoryBox() async {
    _categoryBox =  Hive.box<CategoryHive>('categoryBox');
  }

  @override
  Future<Map<String, CategoryHive>> getAllCategories() async {
    Map<String, CategoryHive> allCategories = {};

    if (_categoryBox != null) {
      for (var key in _categoryBox!.keys) {
        var category = _categoryBox!.get(key);
        if (category != null) {
          allCategories[key] = category;
        }
      }
    }
    return allCategories;
  }

  @override
  Future<void> addCategory(String key, CategoryHive category) async {
    if (_categoryBox != null) {
      await _categoryBox!.put(key, category);
    }
  }

  @override
  CategoryHive? getCategory(String key) {
    return _categoryBox?.get(key);
  }

  @override
  Future<void> updateCategory(String key, CategoryHive category) async {
    if (_categoryBox != null) {
      await _categoryBox!.put(key, category);
    }
  }

  @override
  Future<void> deleteCategory(String key) async {
    if (_categoryBox != null) {
      await _categoryBox!.delete(key);
    }
  }
}
