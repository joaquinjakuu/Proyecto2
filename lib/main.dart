import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_router.dart';
import 'package:myapp/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( 
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MainApp(),
    ),
    );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
