import 'package:baatchit/authentication/login_number.dart';
import 'package:baatchit/controller/firebase_controller.dart';
import 'package:baatchit/controller/storage_controller.dart';
import 'package:baatchit/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatController()),
        ChangeNotifierProvider(create: (context) => StorageController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BaatChit',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 129, 185, 222)),
          scaffoldBackgroundColor: const Color.fromARGB(255, 206, 195, 194),
        ),
        // home: const HomeScreen(),
        home: LoginNumber(),
      ),
    );
  }
}
