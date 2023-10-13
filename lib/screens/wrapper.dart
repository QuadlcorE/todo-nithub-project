import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/user.dart';
import 'package:todo/screens/authenticate/authenticate.dart';
import 'package:todo/screens/home/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TodoUser?>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
