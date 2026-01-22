import 'package:isar/isar.dart';

part 'gacha_item_entity.g.dart';

@collection
@Name('GachaItem')
class GachaItemEntity {
  Id id = Isar.autoIncrement; // 自動採番ID

  @Index(type: IndexType.value)
  late String name; // アイテム名
  late String rarity; // レアリティ
  late int weight; // 確率
}