import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/widgets/navigation_button.dart';
import 'gacha_page.dart';
import 'gacha_collection_page.dart';
import 'gacha_manage_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('トップ画面')),
          children: [
            NavigationButton(destination: GachaPage(), text: 'ガチャ画面へ'),
            NavigationButton(destination: GachaCollectionPage(), text: 'コレクション画面へ'),
            NavigationButton(destination: GachaManagePage(), text: 'ガチャ管理へ'),
          ],
        ),
      ),
    );
  }
}
