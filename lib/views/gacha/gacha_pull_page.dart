import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/domains/Entity/gacha_item_entity.dart';
import 'package:gacha_app/services/GachaService.dart';
import 'package:gacha_app/providers/gacha_item_entity_provider.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/gacha/gacha_animation_screen.dart';

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
                  if (result != null) _startGachaSequence(context, [result]); // リストにして渡す
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
                  _startGachaSequence(context, results);
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

  void _startGachaSequence(BuildContext context, List<GachaItemEntity> results) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // 背景を透過させる
        pageBuilder: (context, _, __) => GachaAnimationScreen(results: results),
        transitionsBuilder: (context, animation, _, child) {
          // フェードインで演出画面を表示
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}

