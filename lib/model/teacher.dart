import 'package:hive/hive.dart';

part 'teacher.g.dart';

@HiveType(typeId: 1)
class Teacher extends HiveObject {
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String subject;

  Teacher({required this.id, required this.name, required this.age, required this.subject});
}

//RUNNER : flutter packages pub run build_runner build --delete-conflicting-outputs
