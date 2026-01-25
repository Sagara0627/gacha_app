import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/providers/gacha_item_entity_provider.dart';

class GachaCollectionPage extends ConsumerWidget {
  const GachaCollectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. DBのデータをリアルタイム監視
    final gachaItemsAsync = ref.watch(gachaItemEntityListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('コレクション画面')),
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
    );
  }
}
