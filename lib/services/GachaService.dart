import 'dart:math';
import 'package:gacha_app/domains/Entity/gacha_item_entity.dart';

class GachaService {
  GachaItemEntity? draw(List<GachaItemEntity> items) {
    if (items.isEmpty) return null;
    final totalWeight = items.fold<int>(0, (sum, item) => sum + item.weight);
    final randomValue = Random().nextInt(totalWeight);

    int currentSum = 0;
    for (final item in items) {
      currentSum += item.weight;
      if (randomValue < currentSum) return item;
    }
    return items.last;
  }

  List<GachaItemEntity> drawMultiple(List<GachaItemEntity> items, int count) {
    return List.generate(count, (_) => draw(items))
        .whereType<GachaItemEntity>()
        .toList();
  }
}