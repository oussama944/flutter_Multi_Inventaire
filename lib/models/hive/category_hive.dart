import 'package:hive/hive.dart';

part 'category_hive.g.dart'; // Généré par Hive

const orangeValue = 0xFFFFA500; // La valeur de Colors.orange en hexadécimal

@HiveType(typeId: 0) // typeId doit être unique pour chaque type
class CategoryHive {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int color; // Stocké en tant qu'int

  const CategoryHive({
    required this.id,
    required this.title,
    this.color = orangeValue, 
  });
}
