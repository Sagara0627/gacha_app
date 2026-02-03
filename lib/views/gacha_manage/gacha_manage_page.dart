import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './gacha_create_page.dart';
import './gacha_detail_page.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/common/navigation_button.dart';
import 'package:gacha_app/providers/gacha_series_entity_provider.dart';

class GachaManagePage extends ConsumerWidget {
  const GachaManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seriesAsync = ref.watch(gachaSeriesEntityListProvider); // DBのデータをリアルタイム監視

    return CommonLayout(
      title: 'ガチャシリーズ一覧',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: seriesAsync.when(
              data: (allSeries) => allSeries.isEmpty
                ? const Center(child: Text('作成済みのシリーズがありません。'))
                : ListView.builder(
                  itemCount: allSeries.length,
                  itemBuilder: (context, index) {
                    final series = allSeries[index];
                    return TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GachaDetailPage(seriesId: series.id,)),
                        );
                      },
                      child: Text(series.name)
                    );
                  },
                ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('エラー: $err')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NavigationButton(
              text: 'シリーズを新規作成',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GachaCreatePage()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
