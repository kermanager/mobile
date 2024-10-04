import 'package:go_router/go_router.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/providers/auth_user.dart';

import 'package:kermanager/router/parent/bottom_navigation.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/screens/parent/dashboard_screen.dart';
import 'package:kermanager/screens/parent/kermesse_details_screen.dart';
import 'package:kermanager/screens/parent/kermesse_list_screen.dart';
import 'package:kermanager/screens/parent/kermesse_stand_details_screen.dart';
import 'package:kermanager/screens/parent/kermesse_stand_list_screen.dart';
import 'package:kermanager/screens/parent/kermesse_user_list_screen.dart';
import 'package:kermanager/screens/parent/user_credit_edit_screen.dart';
import 'package:kermanager/screens/parent/user_credit_send_screen.dart';
import 'package:kermanager/screens/parent/user_details_screen.dart';
import 'package:kermanager/screens/parent/user_edit_screen.dart';
import 'package:provider/provider.dart';

class ParentRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ParentBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.kermesseDetails,
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
          GoRoute(
            path: ParentRoutes.kermesseUserList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseUserListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.kermesseStandList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.kermesseStandDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  standId: params['standId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.userDetails,
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
            path: ParentRoutes.userEdit,
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
          GoRoute(
            path: ParentRoutes.userCreditEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserCreditEditScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.userCreditSend,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserCreditSendScreen(
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
