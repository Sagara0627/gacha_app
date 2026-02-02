import 'package:isar/isar.dart';

part 'gacha_series_entity.g.dart';

@collection
@Name('GachaSeries')
class GachaSeriesEntity {
  Id id = Isar.autoIncrement; // 自動採番ID

  @Index(type: IndexType.value)
  late String name; // アイテム名
}