import 'package:flutter/material.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:sample/domain/repository/db_viewer_repository.dart';

import 'package:sample/pages/home/index.dart';
import 'package:sample/pages/login/index.dart';
import 'package:sample/pages/memo/detail.dart';

class RouteGenerator {
  static const String login = '/login';
  static const String home = '/home';
  static const String memoDetail = '/memoDetail';
  static const String database = '/db-viewer';
  static const String initialRoute = login;

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case login:
        page = LoginPage();
        break;

      case home:
        page = const HomePage();
        break;

      case memoDetail:
        final args = settings.arguments as MemoDetailArguments;
        page = MemoPage(id: args.id);
        break;

      case database:
        final db = DBViewerRepository();
        return MaterialPageRoute(builder: (context) => DriftDbViewer(db));

      default:
        throw const RouteException('Not Found');
    }

    return MaterialPageRoute(
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: page,
      ),
    );
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}

class MemoDetailArguments {
  final int? id;

  MemoDetailArguments(this.id);
}
