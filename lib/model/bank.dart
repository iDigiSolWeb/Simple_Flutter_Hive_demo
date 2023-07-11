import 'package:hive/hive.dart';

///BANK.G IS CREATED BY HIVE GENERATOR IN THE DEV DEPENDENCIES IN PUBSPEC.YAML
part 'bank.g.dart';

///REMEMBER TO INCREMENT TYPE ID FOR EACH MODEL
@HiveType(typeId: 2)

///MUST EXTEND HIVE OBJECT
class Bank extends HiveObject {
  ///CREATE HIVE FIELD INDEX AND IF REQUIRED ADD A DEFAULT VALUE
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int accountNumber;
  @HiveField(3, defaultValue: 0)
  final double amount;

  ///CREATE CONSTRUCTOR
  Bank({required this.id, required this.name, required this.accountNumber, required this.amount});
}

///RUN THE BELOW SCRIPT TO CREATE BANK.G FILE THAT WILL HOLD OUR LOGIC.
// flutter packages pub run build_runner build --delete-conflicting-outputs
