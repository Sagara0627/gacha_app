import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './gacha_detail_page.dart';
import 'package:gacha_app/domains/Entity/gacha_item_entity.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/common/navigation_button.dart';
import 'package:gacha_app/providers/database_provider.dart';

final itemNameProvider = StateProvider.autoDispose<String>((ref) => '');
final itemRarityProvider = StateProvider.autoDispose<String>((ref) => '');
final itemWeightProvider = StateProvider.autoDispose<int>((ref) => 0);

class GachaItemCreatePage extends ConsumerWidget {
  final int seriesId;
  const GachaItemCreatePage({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(itemNameProvider);
    final rarity = ref.watch(itemRarityProvider);
    final weight = ref.watch(itemWeightProvider);
    final isar = ref.watch(isarProvider);

    return CommonLayout(
      title: 'ガチャアイテム新規作成',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            maxLength: 20,
            onChanged: (value) => ref.read(itemNameProvider.notifier).state = value,
          ),
          TextField(
            onChanged: (value) => ref.read(itemRarityProvider.notifier).state = value,
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly], // 数字（0-9）のみ許可
            onChanged: (value) => ref.read(itemWeightProvider.notifier).state = int.parse(value),
          ),
          NavigationButton(
            text: '保存',
            onPressed: () async {
              final newItem = GachaItemEntity()
                ..name = name
                ..seriesId = seriesId
                ..rarity = rarity
                ..weight = weight;
              await isar.writeTxn(() => isar.gachaItemEntitys.put(newItem));
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GachaDetailPage(seriesId: seriesId)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
