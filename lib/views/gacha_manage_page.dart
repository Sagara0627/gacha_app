import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/providers/gacha_item_entity_provider.dart';
import 'package:gacha_app/providers/database_provider.dart';
import '../domains/Entity/gacha_item_entity.dart';

class GachaManagePage extends ConsumerWidget {
  const GachaManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. DBのデータをリアルタイム監視
    final gachaItemsAsync = ref.watch(gachaItemEntityListProvider);
    final isar = ref.watch(isarProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ガチャ管理')),
      body: gachaItemsAsync.when(
        data: (items) => items.isEmpty 
          ? const Center(child: Text('アイテムがありません。右下の＋で追加！'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('レア度: ${item.rarity} (重み: ${item.weight})'),
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
      ),
      // テスト用にアイテムを追加するボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ダミーデータの作成
          final newItem = GachaItemEntity()
            ..name = 'アイテム ${DateTime.now().second}'
            ..rarity = 'SR'
            ..weight = 10;

          await isar.writeTxn(() => isar.gachaItemEntitys.put(newItem)); // DBに保存（保存されると、Riverpodが検知してListViewが自動更新される）
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
