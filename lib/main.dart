import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/screens/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/screens/wrapper.dart';
import 'package:todo/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TodoUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
