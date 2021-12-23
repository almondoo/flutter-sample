import 'package:sample/domain/repository/memo_repository.dart';
import 'package:sample/manager/db.dart';

class MemoService {
  final MemoRepository _repo = MemoRepository();

  // 追加
  Future<bool> addMemo(MemoCompanion entity) async {
    final int id = await _repo.addMemo(entity);
    if (id != 0) {
      return true;
    }
    return false;
  }

  // 更新
  Future<bool> saveMemo(MemoData entity) async {
    return await _repo.updateMemo(entity);
  }

  // 削除
  Future<bool> deleteMemo(int id) async {
    final int num = await _repo.deleteMemo(id);
    if (num > 0) {
      return true;
    }
    return false;
  }
}
