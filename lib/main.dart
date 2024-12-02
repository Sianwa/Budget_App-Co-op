import 'package:budget_app/utils/AppNavigation/route_config.dart';
import 'package:budget_app/utils/service_locator.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Budget App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF80ba27)),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().mainRouter,
    );
  }
}
