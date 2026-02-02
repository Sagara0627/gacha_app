import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './gacha_create_page.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/common/custom_app_bar.dart';
import 'package:gacha_app/widgets/common/navigation_button.dart';
import 'package:gacha_app/providers/gacha_series_entity_provider.dart';

class GachaManagePage extends ConsumerWidget {
  const GachaManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. DBのデータをリアルタイム監視
    final gachaSeriessAsync = ref.watch(gachaSeriesEntityListProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'ガチャシリーズ一覧'),
      body: CommonLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: gachaSeriessAsync.when(
                data: (serieses) => serieses.isEmpty
                  ? const Center(child: Text('作成済みのシリーズがありません。'),)
                  : ListView.builder(
                    itemCount: serieses.length,
                    itemBuilder: (context, index) {
                      final series = serieses[index];
                      return ListTile(title: Text(series.name));
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
      ),
    );
  }
}
