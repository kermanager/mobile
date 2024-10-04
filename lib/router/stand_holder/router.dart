import 'package:go_router/go_router.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/providers/auth_user.dart';

import 'package:kermanager/router/stand_holder/bottom_navigation.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/screens/stand_holder/dashboard_screen.dart';
import 'package:kermanager/screens/stand_holder/user_details_screen.dart';
import 'package:kermanager/screens/stand_holder/user_edit_screen.dart';
import 'package:provider/provider.dart';

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
            path: StandHolderRoutes.userDetails,
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
            path: StandHolderRoutes.userEdit,
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
      ),
    ],
  );
}
