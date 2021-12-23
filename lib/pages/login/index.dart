import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sample/store/login/provider.dart';
import 'package:sample/validator/login_validator.dart';

final _validator =
    ChangeNotifierProvider.autoDispose((ref) => LoginValidator());

final _passwordProvider = StateProvider.autoDispose<bool>((_) => true);

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.read(loginProvider.notifier);
    final bool _isObscure = ref.watch(_passwordProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'パスワードを入力してください。',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        ref.read(_passwordProvider.notifier).state =
                            !ref.read(_passwordProvider);
                      },
                    ),
                  ),
                  autofocus: true,
                  obscureText: _isObscure,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => provider.setPassword(value),
                  validator: ref.watch(_validator).emptyValidator,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    ref.watch(_validator).message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        ref.watch(_validator).setMessage('');
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ref.read(loginProvider.notifier).login();
                          if (!ref.read(loginProvider)) {
                            ref.watch(_validator).setMessage('パスワードが違います。');
                          } else {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        }
                      },
                      child: const Text('ログイン'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
