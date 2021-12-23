import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/domain/repository/memo_repository.dart';
import 'package:sample/manager/db.dart';
import 'package:sample/store/memo/selectors.dart';

class MemoOperation extends StateNotifier<List<MemoData>> {
  MemoOperation() : super(<MemoData>[]) {
    initialize();
  }

  final MemoRepository _repo = MemoRepository();
  final MemoSelector _sele = MemoSelector();

  // 初期化
  void initialize() async {
    setList();
  }

  // operation
  Future<void> setList() async {
    state = await _repo.fetchMemoData();
  }

  // selector
  MemoData findByID(int id) {
    return _sele.findByID(state, id);
  }
}
