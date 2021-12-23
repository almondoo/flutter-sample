import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/entity/memo.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

// todo ここをシングルトンにする
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Memo])
abstract class MemoDatabase extends _$MemoDatabase {
  MemoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
