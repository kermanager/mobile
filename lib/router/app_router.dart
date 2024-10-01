import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      // redirect: (BuildContext context, GoRouterState state) {
      //   return null;
      // },
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
