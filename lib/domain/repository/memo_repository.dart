import 'package:sample/manager/db.dart';

class MemoRepository extends MemoDatabase {
  static final MemoRepository _instance = MemoRepository._internal();
  MemoRepository._internal();
  factory MemoRepository() {
    return _instance;
  }

  Future<List<MemoData>> fetchMemoData() {
    return select(memo).get();
  }

  // insertはidが返却される
  Future<int> addMemo(MemoCompanion entity) {
    return transaction(() async {
      return await into(memo).insert(entity);
    });
  }

  // updateされていたらtrueが返却される
  Future<bool> updateMemo(MemoData entity) {
    return transaction(() async {
      return await update(memo).replace(entity);
    });
  }

  // 削除された数返却される
  Future<int> deleteMemo(int id) {
    return transaction(() async {
      return await (delete(memo)..where((it) => it.id.equals(id))).go();
    });
  }
}
