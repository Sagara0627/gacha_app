import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/providers/database_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'domains/Entity/gacha_item_entity.dart';
import 'views/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutterの初期化待ち

  final dir = await getApplicationDocumentsDirectory(); // 保存先ディレクトリの取得

  final isar = await Isar.open(
    [GachaItemEntitySchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [ isarProvider.overrideWithValue(isar) ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '無限ガチャアプリ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TopPage(),
    );
  }
}
