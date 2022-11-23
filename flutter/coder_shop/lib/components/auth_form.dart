import 'package:flutter/material.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    void _submit() {}

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(
          16,
        ),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';

                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido.';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              controller: _passwordController,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';

                if (password.trim().isEmpty || password.length < 5) {
                  return 'Informe uma senha válida.';
                }

                return null;
              },
            ),
            if (_isSignup())
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';

                  if (password != _passwordController.text) {
                    return 'Senhas informadas não conferem.';
                  }

                  return null;
                },
              ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  )),
            )
          ],
        )),
      ),
    );
  }
}
