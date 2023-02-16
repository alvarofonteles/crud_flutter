import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users_provider.dart';
import 'package:provider/provider.dart';

// pode ser com StatelessWidget ou
//    com StatefulWidget
class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  // Object caso queira passar outros valores
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name!;
    _formData['email'] = user.email!;
    _formData['avatarUrl'] = user.avatarUrl!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User?;

    if (user != null) {
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState!.save();

                  // generic '<>' >> Provider.of<UsersProvider>(context)
                  // provider não precisa ser notificado (não atualiza a tela) ' listen: false'
                  Provider.of<UsersProvider>(context, listen: false).put(
                    User(
                        id: _formData['id'],
                        name: _formData['name'],
                        email: _formData['email'],
                        avatarUrl: _formData['avatarUrl']),
                  );

                  Navigator.of(context)
                      .pop(); // ele volta para pagina anterior 'Navigator.of(context).pop'
                }
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            TextFormField(
              initialValue: _formData['name'],
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nome Inválido';
                }

                if (value.trim().length < 3 || value.trim().isEmpty) {
                  return 'Maior que 3 letrars';
                }

                return null;
              },
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: const InputDecoration(labelText: 'E-mail'),
              onSaved: (value) => _formData['email'] = value!,
            ),
            TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: const InputDecoration(labelText: 'Url Avatar'),
              onSaved: (value) => _formData['avatarUrl'] = value!,
            )
          ]),
        ),
      ),
    );
  }
}
