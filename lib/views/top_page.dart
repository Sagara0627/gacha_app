import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'gacha_page.dart';
import 'gacha_collection_page.dart';
import 'gacha_manage_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('トップ画面')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverflowBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GachaPage()),
                  );
                },
                child: const Text('ガチャ画面へ'),
              ),
            ],
          ),
          OverflowBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GachaCollectionPage()),
                  );
                },
                child: const Text('コレクション画面へ'),
              ),
            ],
          ),
          OverflowBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GachaManagePage()),
                  );
                },
                child: const Text('ガチャ管理へ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
