import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';

import '../models/auth.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AnimationController? _animationController;
  Animation<Size>? _heightAnimation;

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Fechar',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        microseconds: 300,
      ),
    );

    _heightAnimation = Tween(
      begin: Size(double.infinity, 310),
      end: Size(double.infinity, 400),
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
      ),
    );

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Future<void> _submit() async {
      final bool isValid = _formKey.currentState?.validate() != null;

      if (!isValid) {
        return;
      }

      setState(() {
        _isLoading = true;
      });

      _formKey.currentState?.save();
      Auth auth = Provider.of(context, listen: false);

      try {
        if (_isLogin()) {
          await auth.login(
            _authData['email']!,
            _authData['password']!,
          );
        } else {
          await auth.signup(
            _authData['email']!,
            _authData['password']!,
          );
        }
      } on AuthException catch (error) {
        _showErrorDialog(
          error.toString(),
        );
      } catch (error) {
        _showErrorDialog(
          'Ocorreu um erro inesperado',
        );
      }

      setState(() {
        _isLoading = false;
      });
    }

    void _switchAuthMode() {
      setState(() {
        if (_isLogin()) {
          _authMode = AuthMode.Signup;
          _animationController?.forward();
        } else {
          _authMode = AuthMode.Login;
          _animationController?.reverse();
        }
      });
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: AnimatedBuilder(
        animation: _heightAnimation!,
        builder: (context, childForm) => Container(
          padding: const EdgeInsets.all(
            16,
          ),
          height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
          width: deviceSize.width * 0.75,
          child: childForm,
        ),
        child: Form(
          key: _formKey,
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
              if (_isLoading)
                CircularProgressIndicator()
              else
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
                ),
              Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child:
                    Text(_isLogin() ? 'DESEJA REGISTRAR' : 'JÁ POSSUI CONTA'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
