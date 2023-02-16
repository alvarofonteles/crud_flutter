import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  ObrigadoPai oracao = ObrigadoPai();
  oracao.msg('Obrigado Pai por tudo, eu te Amo.');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const UserList(),
        routes: {
          AppRoutes.HOME: (context) => const UserList(),
          AppRoutes.USER_FORM: (_) => const UserForm(),
        },
      ),
    );
  }
}

class ObrigadoPai {
  void msg(String msg) {
    debugPrint(msg);
  }
}
