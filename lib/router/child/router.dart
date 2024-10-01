import 'package:go_router/go_router.dart';

import 'package:kermanager/router/child/bottom_navigation.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/screens/child/dashboard_screen.dart';
import 'package:kermanager/screens/child/profile_screen.dart';

class ChildRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ChildBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ChildRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ChildRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
