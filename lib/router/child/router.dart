import 'package:go_router/go_router.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/providers/auth_user.dart';

import 'package:kermanager/router/child/bottom_navigation.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/screens/child/dashboard_screen.dart';
import 'package:kermanager/screens/child/user_details_screen.dart';
import 'package:kermanager/screens/child/user_edit_screen.dart';
import 'package:provider/provider.dart';

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
            path: ChildRoutes.userDetails,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserDetailsScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: ChildRoutes.userEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserEditScreen(
                  userId: user.id,
                ),
              );
            },
          ),
        ],
      )
    ],
  );
}
