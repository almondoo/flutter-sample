import 'package:flutter/cupertino.dart';

class LoginValidator extends ChangeNotifier {
  String _message = '';

  get message => _message;

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '入力してください。';
    }
    return null;
  }

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }
}
