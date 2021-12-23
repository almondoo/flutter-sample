import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample/pages/home/index.dart';
import 'package:sample/pages/login/index.dart';
import 'package:sample/route.dart';
import 'package:sample/store/login/provider.dart';

// エントリーポイント
void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAuth = ref.watch(loginProvider);

    return MaterialApp(
      title: 'メモアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: isAuth ? const HomePage() : LoginPage(),
      initialRoute: RouteGenerator.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
