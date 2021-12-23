import 'package:sample/manager/db.dart';

class DBViewerRepository extends MemoDatabase {
  static final DBViewerRepository _instance = DBViewerRepository._internal();
  DBViewerRepository._internal();
  factory DBViewerRepository() {
    return _instance;
  }
}
