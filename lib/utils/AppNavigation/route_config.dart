import 'package:budget_app/screens/NewEntryPage.dart';
import 'package:budget_app/utils/AppNavigation/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../screens/AccountsPage.dart';
import '../../screens/BudgetPage.dart';
import '../../screens/HomePage.dart';
import '../../screens/MainScaffold.dart';
import '../../screens/ReportsPage.dart';
import '../../screens/SuccessScreen.dart';

class AppRouter {
  final GoRouter _mainRouter = GoRouter(initialLocation: homePagePath, routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: homePagePath,
              name: homePage,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const HomePage(),
                transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation secondaryAnimation,
                        Widget child) =>
                    FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
              path: budgetPagePath,
              name: budgetPage,
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: BudgetPage(),
                  transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      )))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: newEntryPagePath,
              name: newEntryPage,
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: NewEntryPage(),
                  transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      )))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: reportsPagePath,
              name: reportsPage,
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: ReportsPage(),
                  transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      )))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: accountsPagePath,
              name: accountsPage,
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: AccountsPage(),
                  transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      )))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: successScreenPath,
              name: successScreen,
              pageBuilder: (context, state) => CustomTransitionPage(
                  child: SuccessScreen(
                    budgetItem: state.uri.queryParameters['budgetItem'],
                    amount: state.uri.queryParameters['amount'],
                  ),
                  transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      )))
        ]),
      ],
    )
  ]);

  GoRouter get mainRouter => _mainRouter;
}
