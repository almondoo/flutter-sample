import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/domain/repository/auth_repository.dart';

class LoginOperation extends StateNotifier<bool> {
  LoginOperation() : super(false) {
    initialize();
  }

  final AuthRepository _repo = AuthRepository();
  String _password = '';

  // 初期化
  void initialize() async {}

  void login() {
    var ok = _repo.auth(_password);
    state = ok;
  }

  void logout() {
    state = false;
  }

  void setPassword(String value) {
    _password = value;
  }
}
