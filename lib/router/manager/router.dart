import 'package:go_router/go_router.dart';
import 'package:kermanager/router/manager/bottom_navigation.dart';

import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/screens/manager/dashboard_screen.dart';
import 'package:kermanager/screens/manager/kermesse_create_screen.dart';
import 'package:kermanager/screens/manager/kermesse_details_screen.dart';
import 'package:kermanager/screens/manager/kermesse_edit_screen.dart';
import 'package:kermanager/screens/manager/kermesse_interaction_details_screen.dart';
import 'package:kermanager/screens/manager/kermesse_interaction_list_screen.dart';
import 'package:kermanager/screens/manager/kermesse_list_screen.dart';
import 'package:kermanager/screens/manager/kermesse_stand_invite_screen.dart';
import 'package:kermanager/screens/manager/kermesse_stand_list_screen.dart';
import 'package:kermanager/screens/manager/kermesse_tombola_create_screen.dart';
import 'package:kermanager/screens/manager/kermesse_tombola_details_screen.dart';
import 'package:kermanager/screens/manager/kermesse_tombola_edit_screen.dart';
import 'package:kermanager/screens/manager/kermesse_tombola_list_screen.dart';
import 'package:kermanager/screens/manager/kermesse_user_list_screen.dart';
import 'package:kermanager/screens/manager/profile_screen.dart';
import 'package:kermanager/screens/manager/ticket_details_screen.dart';
import 'package:kermanager/screens/manager/ticket_list_screen.dart';

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
          GoRoute(
            path: ManagerRoutes.kermesseCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseCreateScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.kermesseEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseEditScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseUserList,
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
            path: ManagerRoutes.kermesseStandList,
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
            path: ManagerRoutes.kermesseStandInvite,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandInviteScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseTombolaList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseTombolaDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseTombolaCreate,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaCreateScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseTombolaEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaEditScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseInteractionList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ManagerRoutes.kermesseInteractionDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  interactionId: params['interactionId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.ticketDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: TicketDetailsScreen(
                  ticketId: params['ticketId']!,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
