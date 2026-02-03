import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/providers/gacha_item_entity_provider.dart';
import 'package:gacha_app/views/gacha_manage/gacha_item_create_page.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/common/navigation_button.dart';

final gachaNameProvider = StateProvider.autoDispose<String>((ref) => '');

class GachaDetailPage extends ConsumerWidget {
  final int seriesId;

  const GachaDetailPage({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsFilteredSeries = ref.watch(gachaItemsFilteredSeriesIdProvider(seriesId));

    return CommonLayout(
      title: 'シリーズ詳細',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: itemsFilteredSeries.when(
              data: (items) => items.isEmpty
                ? const Center(child: Text('アイテムがありません。'))
                : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(title: Text(item.name));
                  }
                ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('エラー: $err')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NavigationButton(
              text: 'アイテムを追加',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GachaItemCreatePage(seriesId: seriesId)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
