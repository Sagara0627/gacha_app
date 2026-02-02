import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'database_provider.dart';
import '/domains/Entity/gacha_series_entity.dart';

// 全アイテムを監視するStream
final gachaSeriesEntityListProvider = StreamProvider<List<GachaSeriesEntity>>((ref) {
  final isar = ref.watch(isarProvider);
  
  // .watch(fireImmediately: true) を使うことで、
  // 最初の一回＋中身が変わるたびに最新のリストを流してくれる
  return isar.gachaSeriesEntitys.where().watch(fireImmediately: true);
});