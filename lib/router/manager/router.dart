import 'package:go_router/go_router.dart';
import 'package:kermanager/router/manager/bottom_navigation.dart';

import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/screens/manager/dashboard_screen.dart';
import 'package:kermanager/screens/manager/kermesse_details_screen.dart';
import 'package:kermanager/screens/manager/kermesse_list_screen.dart';
import 'package:kermanager/screens/manager/profile_screen.dart';

class ManagerRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ManagerBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.kermesseDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseDetailsScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
