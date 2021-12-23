import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/manager/db.dart';
import 'package:sample/store/memo/operations.dart';

final memoProvider = StateNotifierProvider<MemoOperation, List<MemoData>>(
    (_) => MemoOperation());
