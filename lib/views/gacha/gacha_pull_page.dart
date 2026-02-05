import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/domains/Entity/gacha_item_entity.dart';
import 'package:gacha_app/services/GachaService.dart';
import 'package:gacha_app/providers/gacha_item_entity_provider.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';

class GachaPullPage extends ConsumerWidget {
  final int seriesId;
  const GachaPullPage({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsFilteredSeries = ref.watch(gachaItemsFilteredSeriesIdProvider(seriesId));

    return CommonLayout(
      title: 'ガチャを引く画面',
      child: Center(
        child: itemsFilteredSeries.when(
          data: (items) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1回引くボタン
              ElevatedButton(
                onPressed: items.isEmpty ? null : () {
                  final result = GachaService().draw(items);
                  if (result != null) _showResultDialog(context, [result]); // リストにして渡す
                },
                child: const Text('1回引く'),
              ),
              const SizedBox(height: 10),
              // 10連ボタン
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: items.isEmpty ? null : () {
                  // 10回分抽選
                  final results = GachaService().drawMultiple(items, 10);
                  _showResultDialog(context, results);
                },
                child: const Text('10連ガチャ！！'),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('エラーが発生しました: $err'),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, List<GachaItemEntity> results) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(results.length == 1 ? '獲得アイテム' : '10連ガチャ結果'),
        content: SizedBox(
          width: double.maxFinite, // ダイアログの横幅を確保
          child: ListView.builder(
            shrinkWrap: true, // コンテンツの大きさに合わせる
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return ListTile(
                leading: CircleAvatar(child: Text(item.rarity)),
                title: Text(item.name),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }
}

