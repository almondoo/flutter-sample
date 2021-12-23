import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/domain/service/memo_service.dart';
import 'package:sample/manager/db.dart';
import 'package:sample/store/memo/provider.dart';

// ignore: must_be_immutable
class MemoPage extends HookConsumerWidget {
  MemoPage({Key? key, required this.id}) : super(key: key);
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
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoDetail'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _item?.title,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  hintText: '一覧に載るタイトル',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '入力してください。';
                  }
                  return null;
                },
                onChanged: (String value) => _title = value,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  initialValue: _item?.content,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: '内容',
                    hintText: 'メモの詳細内容を記述',
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '入力してください。';
                    }
                    return null;
                  },
                  onChanged: (String value) => _content = value,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Visibility(
                      visible: _item != null,
                      child: TextButton(
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
                        child: const Text(
                          '削除',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '戻る',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
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
                        child: const Text(
                          '保存',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
