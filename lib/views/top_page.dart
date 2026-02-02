import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gacha_app/widgets/common/common_layout.dart';
import 'package:gacha_app/widgets/common/navigation_button.dart';
import 'gacha/gacha_page.dart';
import 'gacha_collection/gacha_collection_page.dart';
import 'gacha_manage/gacha_manage_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonLayout(
      title: 'トップ画面',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationButton(
            text: 'ガチャ画面へ',
            onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => GachaPage())) },
          ),
          NavigationButton(
            text: 'コレクション画面へ',
            onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => GachaCollectionPage())) },
          ),
          NavigationButton(
            text: 'ガチャ管理へ',
            onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => GachaManagePage())) },
          ),
        ],
      ),
    );
  }
}
