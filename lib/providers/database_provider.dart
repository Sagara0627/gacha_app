import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// アプリ全体で使うIsarインスタンスを保持するProvider
// 初期化前はエラーを投げるようにし、main.dartで上書き(override)
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError();
});
