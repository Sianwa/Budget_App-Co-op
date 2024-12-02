import 'package:get_it/get_it.dart';
import '../database/BudgetDatabase.dart';

final GetIt locator = GetIt.instance;

Future setUpLocator() async{
  locator.registerSingletonAsync<BudgetDatabase>(
        () async {
      final database = BudgetDatabase.instance;
      await database.database;
      return database;
    },
  );
}