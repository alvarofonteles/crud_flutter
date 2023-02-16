import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    // 'listen: true' false não notifica entao nao atualiza a tela
    final UsersProvider users = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Usuários',
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                );
                // testando a funcao adicionar do provider
                /*users.put(const User(
                    name: 'Alvaro',
                    email: 'alvarofonteles@hotmail.com',
                    avatarUrl: ''));*/
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i))),
    );
  }
}
