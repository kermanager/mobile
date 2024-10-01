import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kermanager/app.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(
        router: AppRouter(),
      ),
    ),
  );
}
