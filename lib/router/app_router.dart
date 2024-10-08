import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:kermanager/providers/auth_user.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/manager/router.dart';
import 'package:kermanager/router/auth/router.dart';
import 'package:kermanager/router/auth/routes.dart';
import 'package:kermanager/router/stand_holder/router.dart';
import 'package:kermanager/router/parent/router.dart';
import 'package:kermanager/router/child/router.dart';

class AppRouter {
  GoRouter goRouter(BuildContext context) {
    return GoRouter(
      initialLocation: AuthRoutes.signIn,
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      redirect: (BuildContext context, GoRouterState state) {
        AuthUser user = Provider.of<AuthProvider>(context, listen: false).user;
        final bool isLogged =
            Provider.of<AuthProvider>(context, listen: false).isLogged;
        if (!isLogged && !state.fullPath!.startsWith("/auth")) {
          return AuthRoutes.signIn;
        }
        if (isLogged && state.fullPath!.startsWith("/auth")) {
          if (user.role == "MANAGER") {
            return ManagerRoutes.kermesseList;
          } else if (user.role == "STAND_HOLDER") {
            return StandHolderRoutes.standDetails;
          } else if (user.role == "PARENT") {
            return ParentRoutes.kermesseList;
          } else if (user.role == "CHILD") {
            return ChildRoutes.kermesseList;
          }
        }
        if (isLogged && user.role == "STAND_HOLDER" && !user.hasStand) {
          return StandHolderRoutes.standCreate;
        }
        if (isLogged &&
            user.role == "STAND_HOLDER" &&
            user.hasStand &&
            state.fullPath!.startsWith("/stand-holder/stand-create")) {
          return StandHolderRoutes.standDetails;
        }
        return state.fullPath;
      },
      routes: [
        ...AuthRouter.routes,
        ManagerRouter.routes,
        StandHolderRouter.routes,
        ParentRouter.routes,
        ChildRouter.routes,
      ],
    );
  }
}
