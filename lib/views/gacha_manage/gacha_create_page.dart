import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './gacha_manage_page.dart';
import 'package:gacha_app/domains/Entity/gacha_series_entity.dart';
import 'package:gacha_app/widgets/common_layout.dart';
import 'package:gacha_app/widgets/navigation_button.dart';
import 'package:gacha_app/providers/database_provider.dart';

final gachaNameProvider = StateProvider.autoDispose<String>((ref) => '');

class GachaCreatePage extends ConsumerWidget {
  const GachaCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(gachaNameProvider);
    final isar = ref.watch(isarProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('シリーズ新規作成')),
      body: CommonLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              maxLength: 20,
              onChanged: (value) => ref.read(gachaNameProvider.notifier).state = value,
            ),
            NavigationButton(
              text: '保存',
              onPressed: () async {
                // ダミーデータの作成
                final newItem = GachaSeriesEntity()..name = name;
                await isar.writeTxn(() => isar.gachaSeriesEntitys.put(newItem));

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GachaManagePage()),
                  );
                }
              },
              // destination: GachaManagePage(), text: '保存',
            ),
          ],
        ),
      ),
    );
  }
}
