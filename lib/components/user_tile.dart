import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User? user;
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user == null || user!.avatarUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl!));

    return ListTile(
      leading: avatar,
      title: Text(user!.name!),
      subtitle: Text(user!.email!),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user!,
                  );
                },
                icon: const Icon(Icons.edit),
                color: Colors.orange),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Atenção!'),
                    content: const Text('Deseja excluir o usuário?'),
                    actions: <Widget>[
                      // FlatButton deprecate

                      // botão setado
                      OutlinedButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),

                      TextButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                        ),
                        child: const Text('Sim'),
                        onPressed: () {
                          Provider.of<UsersProvider>(context, listen: false)
                              .remove(user!);
                          Navigator.of(context).pop(true);
                        },
                      ),

                      // ou ElevatedButton
                    ],
                  ),
                ).then((confimed) {
                  // pois retorna uma Future, chama apos fechar o dialog
                  if (confimed) {
                    Provider.of<UsersProvider>(context, listen: false)
                        .remove(user!);
                  }
                });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
