import 'package:go_router/go_router.dart';

import 'package:kermanager/router/stand_holder/bottom_navigation.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/screens/stand_holder/dashboard_screen.dart';
import 'package:kermanager/screens/stand_holder/profile_screen.dart';

class StandHolderRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return StandHolderBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: StandHolderRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: StandHolderRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
