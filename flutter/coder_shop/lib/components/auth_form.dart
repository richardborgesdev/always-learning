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
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
            ),
            if (_authMode == AuthMode.Login)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
              ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text(_authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'),
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
