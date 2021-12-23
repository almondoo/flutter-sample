import 'package:sample/manager/db.dart';

class AuthRepository extends MemoDatabase {
  static final AuthRepository _instance = AuthRepository._internal();
  AuthRepository._internal();
  factory AuthRepository() {
    return _instance;
  }

  bool auth(String? password) {
    bool _isAuth = false;
    if (password == 'password') {
      _isAuth = true;
    }
    return _isAuth;
  }

  Future<List<MemoData>> fetchMemoData() {
    return select(memo).get();
  }
}
