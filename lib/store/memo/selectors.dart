import 'package:sample/manager/db.dart';

class MemoSelector {
  MemoData findByID(List<MemoData> items, int id) {
    return items.firstWhere((MemoData data) => data.id == id);
  }
}
