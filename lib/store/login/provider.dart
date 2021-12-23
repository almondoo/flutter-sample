import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/store/login/operations.dart';

final loginProvider = StateNotifierProvider<LoginOperation, bool>((ref) {
  return LoginOperation();
});
