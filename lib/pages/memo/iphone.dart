import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/domain/service/memo_service.dart';
import 'package:sample/manager/db.dart';
import 'package:sample/store/memo/provider.dart';

// ignore: must_be_immutable
class MemoIphoneLikePage extends HookConsumerWidget {
  MemoIphoneLikePage({Key? key, required this.id}) : super(key: key);
  final int? id;
  final _formKey = GlobalKey<FormState>();
  final mService = MemoService();

  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MemoData? _item;
    // HACK: nullチェックしているが中でidがint?からintにキャストされない
    if (id != null && id is int) {
      _item = ref.read(memoProvider.notifier).findByID(id as int);
      _title = _item.title;
      _content = _item.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoDetail'),
        actions: <Widget>[
          Visibility(
            visible: _item != null,
            child: IconButton(
              onPressed: () async {
                try {
                  if (_item != null) {
                    await mService.deleteMemo(_item.id);
                  }
                } catch (e) {
                  throw Exception('削除に失敗しました。');
                }
                ref.read(memoProvider.notifier).setList();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _title = _content.split(RegExp(r'(\n|\r\n|\r)')).first;
                try {
                  if (_item == null) {
                    await mService.addMemo(MemoCompanion(
                        title: drift.Value(_title),
                        content: drift.Value(_content)));
                  } else {
                    await mService.saveMemo(MemoData(
                      id: _item.id,
                      title: _title,
                      content: _content,
                    ));
                  }
                } catch (e) {
                  throw Exception('保存に失敗しました。');
                }
                ref.read(memoProvider.notifier).setList();
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _item?.content,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 20,
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '入力してください。';
                    }
                    return null;
                  },
                  onChanged: (String value) => _content = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
