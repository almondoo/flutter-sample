import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/route.dart';
import 'package:sample/store/login/provider.dart';
import 'package:sample/store/memo/provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _items = ref.watch(memoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              ref.read(loginProvider.notifier).logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Text(
              'ログアウト',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text('ヘッダー'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: const Text("データベース"),
              trailing: const Icon(Icons.storage),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.database);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 20,
            ),
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              final _item = _items[index];
              return Card(
                child: ListTile(
                  title: Text(_item.title),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RouteGenerator.memoDetail,
                      arguments: MemoDetailArguments(_item.id),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/memoDetail',
            arguments: MemoDetailArguments(null),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
