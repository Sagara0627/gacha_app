import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'database_provider.dart';
import '/domains/Entity/gacha_item_entity.dart';

// 全アイテムを監視するStream
final gachaItemEntityListProvider = StreamProvider<List<GachaItemEntity>>((ref) {
  final isar = ref.watch(isarProvider);
  
  // .watch(fireImmediately: true) を使うことで、
  // 最初の一回＋中身が変わるたびに最新のリストを流してくれる
  return isar.gachaItemEntitys.where().watch(fireImmediately: true);
});